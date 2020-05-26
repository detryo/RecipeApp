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
    
    let breakfast = [ Recipe(title: "Slow cooker breakfast beans", imageName: "Slow cooker breakfast beans", ingridients: "1 tbsp olive oil. \n4 1 onion thinly sliced. \n4 2 garlic cloves. chopped, \n4 1 tbsp white or red wine vinegar. \n4 1 heaped tbsp soft brown sugar. \n4 400g can pinto beans, drained and rinsed. \n4 200ml passata. \n4 small bunch coriander, chopped ", instructions: "Heat the slow cooker if necessary.\n4 Heat the oil in a large frying pan and fry the onion until it starts to brown,\n4 then add the garlic and cook for 1 min.\n4 Add the vinegar and sugar and bubble for a minute.\n4 Stir in the beans and passata and season with black pepper.\n4 Tip everything into the slow cooker.", preparation: "5 HRS", timeToCook: "30 MINS", difficulty: "EASY", serves: "SERVES 4")]
    
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
