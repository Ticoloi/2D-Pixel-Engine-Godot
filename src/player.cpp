#include "player.h"
#include <godot_cpp/godot.hpp>
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/classes/node.hpp>

using namespace godot;


/**
* TO DO LIST: 
*   last_direction/direction can be more optimized?
*   
*   Adding a actor* so this way, it will be easier and
*   not need to always be looking for actor always.
*
*/

void Player::_bind_methods() {
    // Defining actor
	ClassDB::bind_method(D_METHOD("get_actor_path"), &Player::get_actor_path);
	ClassDB::bind_method(D_METHOD("set_actor_path", "p_actor_path"), &Player::set_actor_path);

    ADD_PROPERTY(PropertyInfo(Variant::NODE_PATH, "actor_path", PROPERTY_HINT_NODE_PATH_VALID_TYPES, "Actor"), "set_actor_path", "get_actor_path");

    ADD_SIGNAL(MethodInfo("interact"));
}

Player::Player()
{
    m_input = Input::get_singleton();
    
    this->actor_path = NodePath();

    this->run_animation_speed = 0.7;

}

void Player::_process(double delta)
{
	
}

void godot::Player::_ready()
{   
    Actor* actor = get_node<Actor>(this->actor_path);
    if(actor != nullptr){
        // Obuisly, if it has actor that means its actor is a player
        // define it!
        actor->set_is_player(true);
    }
    
}

void Player::_physics_process(double delta)
{
	//var dir_x = Input.get_action_strength("ui_right") - 1*Input.get_action_strength("ui_left")
	//var dir_y = Input.get_action_strength("ui_down") - 1*Input.get_action_strength("ui_up")
	
	//character.direction = Vector2(dir_x, dir_y)
    
    Actor* actor = get_node<Actor>(this->actor_path);
    if(actor != nullptr){
        // If actor != nullptrn, then 
        // we will process inputs
        double dir_x = m_input->get_action_strength("ui_right") -  m_input->get_action_strength("ui_left");
        double dir_y = m_input->get_action_strength("ui_down") -  m_input->get_action_strength("ui_up");
        actor->set_direction(Vector2(dir_x, dir_y));
        actor->set_running(m_input->is_action_pressed("run"));
        if(m_input->is_action_just_pressed("ui_accept")){
            // Interaction with nodes
            emit_signal("interact");
        }
    }
}

NodePath Player::get_actor_path() const
{
    return this->actor_path;
}



void Player::set_actor_path(const NodePath& p_actor_path)
{
    this->actor_path = p_actor_path;
    Actor* actor = get_node<Actor>(this->actor_path);
    
}

