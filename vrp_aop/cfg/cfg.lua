--blimp_id and color at https://docs.fivem.net/docs/game-references/blips/

local cfg = {}

cfg.entity_1 = {"PoI", {blip_id = -1}} 									--for the ones you DONT want to have a blimp
cfg.entity_2 = {"PoI", {blip_id = 269, blip_color = 2}}					--for the ones you want to have a blimp

--perms
cfg.admin = "admin.god"										--admin or higher perms(change for people you want to use menu)but cant vote
cfg.nuser = "player.phone"									--all player (recomend not changeing) can only vote

cfg.aop_display = true

cfg.vote = 10															--number of votes needed to set new aop

cfg.auto = false														--allows auto aop to loop
cfg.refresh = 1															-- minutes till auto aop makes new selection	

--value is used for voting purposes
cfg.aop = {
    {name = "Statewide", pos = {0,0,0}},
    {name = "Blaine County", pos = {901.24, 5261.13, 385.65}}, 
	{name = "LS County", pos = {130.33, 660.04, 208.00}},
    {name = "Sandy/Harmony/Grapeseed", pos = {2343.50, 3944.49, 36.23}},
	{name = "TBD", pos = {0,0,0}},
	--{name = "ChangeMe", pos = {0,0,0}},								--new entry
}

--vote_1 - vote_5 are the sperate displays for all posistions
cfg.display_css = [[
.div_aop{
  position: absolute;
  bottom: 10%;
  left: 16%;
  font-size: 25px;
  font-family: Pricedown;
  color: white;
}
.div_vote_1{
  position: absolute;
  top: 3%;
  left: 20%;
  font-size: 20px;
  font-family: Pricedown;
  color: green;
  text-shadow: 1px 1px #ffffff;
}
.div_vote_2{
  position: absolute;
  top: 3%;
  left: 35%;
  font-size: 20px;
  font-family: Pricedown;
  color: green;
  text-shadow: 2px 2px #ffffff;
}
.div_vote_3{
  position: absolute;
  top: 3%;
  left: 50%;
  font-size: 20px;
  font-family: Pricedown;
  color: green;
  text-shadow: 2px 2px #ffffff;
}
.div_vote_4{
  position: absolute;
  top: 3%;
  left: 65%;
  font-size: 20px;
  font-family: Pricedown;
  color: green;
  text-shadow: 2px 2px #ffffff;
}
.div_vote_5{
  position: absolute;
  top: 3%;
  left: 80%;
  font-size: 20px;
  font-family: Pricedown;
  color: green;
  text-shadow: 2px 2px #ffffff;
}
/* new entry
.div_vote_6{
  position: absolute;
  top: 3%;
  left: 80%;
  font-size: 20px;
  font-family: Pricedown;
  color: green;
  text-shadow: 2px 2px #ffffff;
}
*/
]]

return cfg