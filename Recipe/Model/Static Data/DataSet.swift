//
//  DataSet.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 21/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import Foundation

class DataSet {
    
    let categories = [StaticFoodCategory(title: "Breakfast", imageName: "High protein breakfast"),
                      StaticFoodCategory(title: "Pasta", imageName: "Creamy courgette & bacon pasta")]
    
    let breakfast = [StaticRecipe(title:"Slow cooker breakfast beans" ,imageName: "Slow cooker breakfast beans", ingridients: "1 tbsp olive oil. \n 1 onion thinly sliced. \n 2 garlic cloves. chopped, \n 1 tbsp white or red wine vinegar. \n 1 heaped tbsp soft brown sugar. \n 400g can pinto beans, drained and rinsed. \n 200ml passata. \n small bunch coriander, chopped ", instructions: "Heat the slow cooker if necessary.\n Heat the oil in a large frying pan and fry the onion until it starts to brown,\n then add the garlic and cook for 1 min.\n Add the vinegar and sugar and bubble for a minute.\n Stir in the beans and passata and season with black pepper.\n Tip everything into the slow cooker.", preparation: "5 HRS", timeToCook: "30 MINS", difficulty: "EASY", serves: "SERVES 4"),
                      StaticRecipe(title: "High protein breakfast", imageName: "High protein breakfast", ingridients: "15ml olive oil. \n 130g tomatoes, halved. \n 4 rashers turkey bacon. \n 180g sirloin steak trimmed of visible fat. \n 150g mushrooms sliced. \n4 160g spinach. \n 1 egg", instructions: "Heat grill to high. \n Drizzle a little of the oil on your tomatoes and season well \n Lay the tomatoes on a \n baking tray lined with foil and place under the grill. \n Cook for 4-5 mins, then add the bacon to the tray. \n Turn the bacon as necessary until it is cooked through. \n Turn off the grill and shut the door to keep everything warm. \n Meanwhile, heat the remaining oil in a large, \n non-stick frying pan over a high heat. \n Season your steak well and, \n when the pan is very hot, \n fry for 3-4 mins each side for medium-rare, \n then leave it to rest until you are ready to eat. \n While the steak is resting \n  throw the mushrooms into the still-hot pan, \n fry for 2-3 mins until browned, \n then move to one side of the pan \n Add the spinach to the other side of the pan and cook until wilted. \n Put a saucepan of water on to boil. \n Crack the egg into the boiling water, \n then reduce the heat until the water is gently simmering. \n Poach the egg for 3-4 mins or until the white has set but the yolk is still runny. \n Carefully lift it out with a slotted spoon and drain on kitchen paper. \n Serve everything together and top with the poached egg.", preparation: "5 MIN", timeToCook: "20 MIN", difficulty: "EASY", serves: "SERVES 1")]
    
    let pasta = [ StaticRecipe(title: "Creamy courgette & bacon pasta", imageName: "Creamy courgette & bacon pasta", ingridients: "1 tsp olive oil. \n 150g diced pancetta or smoked bacon lardons. \n 4 courgettes, coarsely grated \n 1 garlic clove, crushed. \n handful freshly grated parmesan. \n 1 small tub (200g) low-fat crème fraîche. \n 300g tagliatelle", instructions: "Heat the olive oil in a large frying pan and sizzle the pancetta or bacon for about 5 mins until starting to crisp. Turn up the heat and add the grated courgette to the pan. Cook for 5 mins or until soft and starting to brown then add the garlic and cook for a minute longer. Season and set aside.", preparation: "10 MINS", timeToCook: "20 MINS", difficulty: "EASY", serves: "SERVES 4"),
                  StaticRecipe(title: "Tuna pasta bake", imageName: "Tuna pasta bake", ingridients: "600g rigatoni \n 50g butter \n 50g plain flour \n 600ml milk \n 250g strong cheddar grated \n 2 x 160g cans tuna steak in spring water, drained \n 330g can sweetcorn drained \n large handful chopped parsley", instructions: "Heat oven to 180C/fan 160C/gas 4. \n Boil 600g rigatoni for 2 mins less time than stated on the pack. \n To make the sauce, melt 50g butter in a saucepan and stir in 50g plain flour. \n Cook for 1 min, then gradually stir in 600ml milk to make a thick white sauce. \n Remove from the heat and stir in all but a handful of the 250g grated cheddar. \n Drain the pasta, mix with the white sauce, two 160g drained cans tuna, one 330g drained can sweetcorn and a large handful of chopped parsley, then season. \n Transfer to a baking dish and top with the rest of the grated cheddar. \n Bake for 15-20 mins until the cheese on top is golden and starting to brown.", preparation: "10 MINS", timeToCook: " 40 MINS", difficulty: "EASY", serves: "SERVES 6")]
    
    
    func getRecipe(forCategoryTitle title: String) -> [StaticRecipe] {
        
        switch title {
        case "Breakfast":
            return breakfast
        case "Pasta":
            return pasta
        default:
            return breakfast
        }
    }
}
