//
//  DataSet.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 21/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import Foundation

class DataSet {
    
    let categories = [ FoodCategory(title: "Breakfast", imageName: "Slow cooker breakfast beans"),
                       FoodCategory(title: "Pasta", imageName: "Creamy courgette & bacon pasta")]
    
    let breakfast = [
                     Recipe(title: "Slow cooker breakfast beans", imageName: "Slow cooker breakfast beans", ingridients: "1 tbsp olive oil. \n4 1 onion thinly sliced. \n4 2 garlic cloves. chopped, \n4 1 tbsp white or red wine vinegar. \n4 1 heaped tbsp soft brown sugar. \n4 400g can pinto beans, drained and rinsed. \n4 200ml passata. \n4 small bunch coriander, chopped ", instructions: "Heat the slow cooker if necessary.\n4 Heat the oil in a large frying pan and fry the onion until it starts to brown,\n4 then add the garlic and cook for 1 min.\n4 Add the vinegar and sugar and bubble for a minute.\n4 Stir in the beans and passata and season with black pepper.\n4 Tip everything into the slow cooker.", preparation: "5 HRS", timeToCook: "30 MINS", difficulty: "EASY", serves: "SERVES 4"),
                      Recipe(title: "High protein breakfast", imageName: "High protein breakfast", ingridients: "15ml olive oil. \n4 130g tomatoes, halved. \n4 4 rashers turkey bacon. \n4 180g sirloin steak trimmed of visible fat. \n4 150g mushrooms sliced. \n4 160g spinach. \n4 1 egg", instructions: "Heat grill to high. \n4 Drizzle a little of the oil on your tomatoes and season well \n4 Lay the tomatoes on a \n4 baking tray lined with foil and place under the grill. \n4 Cook for 4-5 mins, then add the bacon to the tray. \n4 Turn the bacon as necessary until it is cooked through. \n4 Turn off the grill and shut the door to keep everything warm. \n4 Meanwhile, heat the remaining oil in a large,   \n4 non-stick frying pan over a high heat. \n4 Season your steak well and, \n4 when the pan is very hot, \n4 fry for 3-4 mins each side for medium-rare, \n4 then leave it to rest until you are ready to eat. \n4 While the steak is resting \n4  throw the mushrooms into the still-hot pan, \n4 fry for 2-3 mins until browned, \n4 then move to one side of the pan \n4 Add the spinach to the other side of the pan and cook until wilted. \n4 Put a saucepan of water on to boil. \n4 Crack the egg into the boiling water, \n4 then reduce the heat until the water is gently simmering. \n4 Poach the egg for 3-4 mins or until the white has set but the yolk is still runny. \n4 Carefully lift it out with a slotted spoon and drain on kitchen paper. \n4 Serve everything together and top with the poached egg.", preparation: "5 MIN", timeToCook: "20 MIN", difficulty: "EASY", serves: "SERVES 1")]
    
    let pasta = [ Recipe(title: "Creamy courgette & bacon pasta", imageName: "Creamy courgette & bacon pasta", ingridients: "1 tsp olive oil. \n4 150g diced pancetta or smoked bacon lardons. \n4 4 courgettes, coarsely grated \n4 1 garlic clove, crushed. \n4 handful freshly grated parmesan. \n4 1 small tub (200g) low-fat crème fraîche. \n4 300g tagliatelle", instructions: "Heat the olive oil in a large frying pan and sizzle the pancetta or bacon for about 5 mins until starting to crisp. Turn up the heat and add the grated courgette to the pan. Cook for 5 mins or until soft and starting to brown then add the garlic and cook for a minute longer. Season and set aside.", preparation: "10 MINS", timeToCook: "20 MINS", difficulty: "EASY", serves: "SERVES 4")]
    
    
    func getRecipe(forCategoryTitle title: String) -> [Recipe] {
        
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
