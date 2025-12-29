extends Resource

#Recurs de interaccio
#Quan un jugador interaccioni amb un altre
#Li envia una interaccio
#Tambe podem tenir projectils, etc


class_name Interaction

enum TYPE {INTERACT}


#Si es 0, llavors es per parlar
#Si es 1, es per parlar
var interaction_type: int = 0

var character: Actor
