SELECT name, idPizza FROM Pizza
WHERE idPizza = 4;



SELECT Ingredient.idIngredient , Ingredient.name
FROM Ingredient
JOIN PizzaIngredient 
ON Ingredient.idIngredient = PizzaIngredient.Ingredient_idIngredient
WHERE PizzaIngredient.Pizza_idPizza = 1;