/datum/job/assistant
	title = "Renegade"
	flag = ASSISTANT
	department_flag = CIVILIAN
	faction = "Renegade"
	total_positions = -1
	spawn_positions = -1
	supervisors = "Renegade leader"
	selection_color = "#dddddd"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	alt_titles = list("Renegade Grunt","Renegade Sniper","Renegade Heavy","Renegade Medic")

	no_random_roll = 1 //Don't become assistant randomly

/datum/job/assistant/equip(var/mob/living/carbon/human/H)
	if(!H)
		return 0
	H.equip_or_collect(new /obj/item/clothing/under/imperialheretic(H), slot_w_uniform)
	H.equip_or_collect(new /obj/item/clothing/shoes/imperialheretic(H), slot_shoes)
	H.equip_or_collect(new H.species.survival_gear(H.back), slot_in_backpack)
	return 1

/datum/job/assistant/get_access()
	if(config.assistant_maint)
		return list(access_maint_tunnels)
	else
		return list()
