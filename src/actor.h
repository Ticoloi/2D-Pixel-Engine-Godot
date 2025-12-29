#ifndef ACTOR_H
#define ACTOR_H

#include <godot_cpp/classes/character_body2d.hpp>

#include <godot_cpp/classes/animated_sprite2d.hpp>

/**
 * What's the Actor?
 * 
 * Well, actor is like a "human", but it can think, or walk
 * its just a vessel.
 * 
 * tihis vessel can be a player too, but normaly not
 * 
 */


namespace godot
{
    class Actor : public godot::CharacterBody2D
    {
        GDCLASS(Actor, CharacterBody2D);

    private:

      double speed; 

      // TotalSpeed is equal speed + run_speed
      double run_speed;

      // If true, player is running
      bool running;

      // If true, this actor is player, it has lots of consequences
      // especialy with the room_change
      bool is_player; 
    
      // How the animated sprite change its speed when running?
      const double ANIMATION_SPEED = 80;

      // Current direction
      Vector2 direction;


      // Last direction never is (0,0)
      // when starting game, its (0,1)
      Vector2 last_direction;

        
      // Our animated sprite is in this path
      NodePath animated_sprite_path;

    protected:
        static void _bind_methods();

    public:

    Actor();

    void _ready() override;

    void _process(double delta) override;
        
    // Funcions modificadores

    // Modify speed
    void set_speed(const double p_speed);
    
    // Modify running speed
    void set_run_speed(const float p_run_speed);

    // modify if running or not
    void set_running(const bool p_running);

    // Modify direction
    void set_direction(const Vector2 p_direction);

    // modify last_direction
    void set_last_direction(const Vector2 p_last_direction);

    // modify our animated sprite path?
    void set_animated_sprite_path(const NodePath p_animated_sprite_path);

    // Its the player?
    void set_is_player(const bool p_is_player);

    // Funcions consultores
    double get_speed() const;


    // What's the 
    double get_run_speed() const;
    
    bool get_running() const;

    bool get_is_player() const;


    Vector2 get_direction() const;

    Vector2 get_last_direction() const;
    
    NodePath get_animated_sprite_path() const;

    };
}

#endif