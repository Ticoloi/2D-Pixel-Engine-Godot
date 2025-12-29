#ifndef PLAYER_H
#define PLAYER_H

#include <godot_cpp/classes/input.hpp>
#include <godot_cpp/classes/character_body2d.hpp>
#include "actor.h"

/**
 * What's the player?
 * 
 * Player is a Node that is a child from Actor
 * this node can recive inputs like up, down, left, right and enter
 * then it will communicate throught actor with its actor_path
 * 
 * ... and with the CharacterInteraction, via a signals
 * 
 * you need to connect all this on editor.
 */


namespace godot
{
    class Player : public godot::Node2D
    {
        GDCLASS(Player, Node2D);

        private:
            // Actor del jugador, es com un atuell, (Hollow Knight)
            NodePath actor_path;

            // input
            Input *m_input = Input::get_singleton();
            float original_speed;
            float run_animation_speed;

            
        protected:
            static void _bind_methods();

        public:

            Player();

            // This is where process is processed
            void _process(double delta) override;

            void _ready() override;


            // This is where input is procesed
            void _physics_process(double delta) override;

            //  Modificadors

            void set_actor_path(const NodePath& p_actor_path);


            // Consultors
        

            NodePath get_actor_path() const;
    };
}

#endif