enum weapons_id_enum{
	minigun,
	flamethrower
};

enum weapons_data_enum{
	damage,
	name[25],
	hitstun

};

new wdata[weapons_id_enum][weapons_data_enum];


weapons_AssignName(){
	strins(wdata[minigun][name], "Minigun", 0);
	
}

weapons_AssignDamage(){
    wdata[minigun][damage]=1; //per bullet

}
