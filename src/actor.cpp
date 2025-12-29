#include "actor.h"
#include <godot_cpp/godot.hpp>
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/classes/node.hpp>

using namespace godot;

/**
* TO DO LIST: 
*   last_direction/direction can be more optimized?
*   
*   Adding a animated_sprite* so this way, it will be easier and
*   not need to always be looking for animated_sprite.
*
*/


void Actor::_bind_methods() {
    // Speed
	ClassDB::bind_method(D_METHOD("get_speed"), &Actor::get_speed);
	ClassDB::bind_method(D_METHOD("set_speed", "p_speed"), &Actor::set_speed);

    ADD_PROPERTY(PropertyInfo(Variant::FLOAT, "speed"), "set_speed", "get_speed");
	// ADD_PROPERTY(PropertyInfo(Variant::FLOAT, "speed", PROPERTY_HINT_RANGE, "0,20,0.01"), "set_speed", "get_speed");

    // Run Speed
	ClassDB::bind_method(D_METHOD("get_run_speed"), &Actor::get_run_speed);
	ClassDB::bind_method(D_METHOD("set_run_speed", "p_run_speed"), &Actor::set_run_speed);

    ADD_PROPERTY(PropertyInfo(Variant::FLOAT, "run_speed"), "set_run_speed", "get_run_speed");

    // Run Speed
	ClassDB::bind_method(D_METHOD("get_running"), &Actor::get_running);
	ClassDB::bind_method(D_METHOD("set_running", "p_running"), &Actor::set_running);

    ADD_PROPERTY(PropertyInfo(Variant::BOOL, "running"), "set_running", "get_running");


    // Is Player
	ClassDB::bind_method(D_METHOD("get_is_player"), &Actor::get_is_player);
	ClassDB::bind_method(D_METHOD("set_is_player", "p_is_player"), &Actor::set_is_player);

    ADD_PROPERTY(PropertyInfo(Variant::BOOL, "is_player"), "set_is_player", "get_is_player");

    // Direction
	ClassDB::bind_method(D_METHOD("get_direction"), &Actor::get_direction);
	ClassDB::bind_method(D_METHOD("set_direction", "p_direction"), &Actor::set_direction);

    ADD_PROPERTY(PropertyInfo(Variant::VECTOR2, "direction"), "set_direction", "get_direction");

    // Last_Direction
	ClassDB::bind_method(D_METHOD("get_last_direction"), &Actor::get_last_direction);
	ClassDB::bind_method(D_METHOD("set_last_direction", "p_last_direction"), &Actor::set_last_direction);

    ADD_PROPERTY(PropertyInfo(Variant::VECTOR2, "last_direction"), "set_last_direction", "get_last_direction");

    // Animated Sprite
	ClassDB::bind_method(D_METHOD("get_animated_sprite"), &Actor::get_animated_sprite_path);
	ClassDB::bind_method(D_METHOD("set_animated_sprite", "p_animated_sprite"), &Actor::set_animated_sprite_path);

    ADD_PROPERTY(PropertyInfo(Variant::NODE_PATH, "animated_sprite", PROPERTY_HINT_NODE_PATH_VALID_TYPES, "AnimatedSprite2D"), "set_animated_sprite", "get_animated_sprite");

    ADD_SIGNAL(MethodInfo("last_direction_changed", PropertyInfo(Variant::VECTOR2, "last_direction")));
    //ADD_SIGNAL(MethodInfo("last_direction_changed", PropertyInfo(Variant::OBJECT, "node"), PropertyInfo(Variant::VECTOR2, "last_direction")));
}


Actor::Actor()
{
    // Just adding default values
    this->speed = 80;
    this->running = false;
    this->run_speed = 120;
    this->direction = Vector2(0,0);
    this->is_player = false;
    this->last_direction = Vector2(0,1);
    this->animated_sprite_path = NodePath();
}

void godot::Actor::_ready()
{
    this->set_last_direction(this->last_direction);
}

void Actor::_process(double delta)
{
	if(!this->direction.is_normalized()){
		this->direction = this->direction.normalized();
	}	
    double final_speed = this->speed;
    if(this->running){
        final_speed = this->run_speed;
    }

	this->move_and_collide(final_speed*this->direction*delta);

    if(this->get_node_or_null(this->get_animated_sprite_path()) != nullptr){
        this->get_node<AnimatedSprite2D>(this->get_animated_sprite_path())->set_speed_scale(final_speed/this->ANIMATION_SPEED);
    }
}


double Actor::get_speed() const{
    return this->speed;
}

bool Actor::get_is_player() const{
    return this->is_player;
}


double Actor::get_run_speed() const
{
    return this->run_speed;
}

bool Actor::get_running() const
{  
   return this->running; 
}

NodePath godot::Actor::get_animated_sprite_path() const
{
    return this->animated_sprite_path;
}

Vector2 Actor::get_direction() const
{
    return this->direction;
}

Vector2 godot::Actor::get_last_direction() const
{
    return this->last_direction;
}

void Actor::set_speed(const double p_speed)
{
    this->speed = p_speed;

}

void Actor::set_run_speed(const float p_run_speed)
{
    this->run_speed = p_run_speed;
}

void godot::Actor::set_running(const bool p_running)
{
    this->running = p_running;
}

void Actor::set_is_player(const bool p_is_player)
{
    this->is_player = p_is_player;
}


void Actor::set_direction(const Vector2 p_direction)
{   
    this->direction = p_direction;
   if(this->direction != Vector2(0,0)){
    // we need to know if direction is equal to 0,0 
        this->set_last_direction(this->direction);
        AnimatedSprite2D *animated_sprite = get_node<AnimatedSprite2D>(this->get_animated_sprite_path());
        if(animated_sprite != nullptr){
            if(abs(this->direction.y) < abs(this->direction.x)){
                animated_sprite->play("walk_horizontal");
                if(this->direction.x < 0){
                    animated_sprite->set_flip_h(true);
                }else{
                    animated_sprite->set_flip_h(false);
                }
            }else{
                if(this->direction.y > 0){
                animated_sprite->play("walk_down");
                }else{
                animated_sprite->play("walk_up");
                }
            }
        }
    }else{
        // When not moving, updates direction
        set_last_direction(this->last_direction);
    }
}

void godot::Actor::set_last_direction(const Vector2 p_last_direction)
{
    this->last_direction = p_last_direction;
    // Envia el senyal
    this->emit_signal("last_direction_changed", this->last_direction);
    if(this->direction == Vector2(0,0)){
        AnimatedSprite2D *animated_sprite =  get_node<AnimatedSprite2D>(this->get_animated_sprite_path());
        if(animated_sprite != nullptr){
            if(abs(this->last_direction.y) < abs(this->last_direction.x)){
                if(this->last_direction.x != 0){
                    animated_sprite->play("idle_horizontal");
                    if(this->last_direction.x < 0){
                        animated_sprite->set_flip_h(true);
                    }else{
                        animated_sprite->set_flip_h(false);
                    }
                }
            }else{
                if(this->last_direction.y >= 0){
                    animated_sprite->play("idle_down");
                }else{
                    animated_sprite->play("idle_up");
                }
            }
        }
    }
}

void godot::Actor::set_animated_sprite_path(const NodePath p_animated_sprite_path)
{
    this->animated_sprite_path = p_animated_sprite_path;
}

