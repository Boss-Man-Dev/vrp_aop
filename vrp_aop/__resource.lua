description "vRP AOP"
--ui_page "ui/index.html"

dependency "vrp"

server_script "@vrp/lib/utils.lua"
server_script "server_vrp.lua"

files{
	"vrp_aop/sounds/aop_start.ogg",
	"vrp_aop/sounds/aop_end.ogg"
}