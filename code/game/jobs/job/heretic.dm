/datum/job/assistant
	title = "Renegade"
	flag = RENEGADE
	department_flag = RENEGADE
	faction = "Thirsters"
	total_positions = -1
	spawn_positions = -1
	supervisors = "Renegade leader"
	selection_color = "#dddddd"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	alt_titles = list("Renegade sniper","Renegade grunt","Renegade heavy","Renegade medic")

	no_random_roll = 1 //Don't become assistant randomly

/datum/job/renegade/equip(var/mob/living/carbon/human/H)
	if(!H)
		return 0
	H.equip_or_collect(new /obj/item/clothing/under/imperialheretic(H), slot_w_uniform)
	H.equip_or_collect(new /obj/item/clothing/shoes/imperialheretic(H), slot_shoes)
	H.equip_or_collect(new H.species.survival_gear(H.back), slot_in_backpack)
	return 1

/datum/job/renegade/get_access()