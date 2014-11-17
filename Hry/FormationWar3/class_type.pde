class Type{
 String name; 
 float body_area;    //[m^2]
 float speed;        //[m/s]
 
 // formation properties
 float width;        //[m]
 float depth;        //[m] 
 
  // deffence 
 float armour; // [J]    AP needed to pentrate
 float shield; // [%]  percent of body covered
 
 // melee combat
 float melee_rate;   // [Hz] how fast execute attacks?
 float melee_AP;     // [J]  armour able to pentrate 
 float melee_skill;  // [?]   able to outperform oponent in duel
 
 // missile
 float missile_dispersion; // [rad] angular dispersion of shots 
 float missile_AP;         // [J]
 float misslile_rate;      // [Hz]
 
 Type(){
   name="default"; 
   body_area=1.0;
   width=0.75; 
   depth=0.75; 
   speed=1.5;
   melee_rate = 1/20.0;    
   melee_AP = 30.0;     
   melee_skill= 5;  
   armour = 10.0; 
   shield = 0.5; 
   missile_dispersion = PI/180.0;
   missile_AP    = 50.0;
   misslile_rate = 1.0/10;
 }
 
 
 
}
