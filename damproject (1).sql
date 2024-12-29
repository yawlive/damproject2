-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 28, 2024 at 11:36 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `damproject`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `CommentID` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `RestaurantID` int(11) DEFAULT NULL,
  `CommentText` text DEFAULT NULL,
  `Review` int(11) DEFAULT NULL CHECK (`Review` between 1 and 5),
  `CommentDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`CommentID`, `email`, `RestaurantID`, `CommentText`, `Review`, `CommentDate`) VALUES
(1, 'nor@gmail.com', 1, 'Great food, but the wait time was a bit long. Would visit again!', 4, '2024-12-28 00:21:38'),
(2, 'mayar@gmail.com', 1, 'Amazing experience, the dishes were delicious!', 5, '2024-12-28 00:21:38'),
(3, 'rah@gmail.com', 1, 'The food was average, but the service was exceptional.', 3, '2024-12-28 00:21:38'),
(4, 'han@gmail.com', 1, 'Very poor experience. Food was cold and service was slow.', 1, '2024-12-28 00:21:38'),
(14, 'mayar@gmail.com', 1, 'the food was cold and the service is so slow', 2, '2024-12-28 16:15:55');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `likeID` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `RestaurantID` int(11) DEFAULT NULL,
  `LikedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`likeID`, `email`, `RestaurantID`, `LikedAt`) VALUES
(7, 'nor@gmail.com', 4, '2024-12-28 18:38:04'),
(9, 'mayar@gmail.com', 3, '2024-12-28 18:53:40'),
(10, 'mayar@gmail.com', 1, '2024-12-28 18:53:44'),
(11, 'mayar@gmail.com', 4, '2024-12-28 18:53:47');

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `Menuid` int(11) NOT NULL,
  `RestaurantID` int(11) NOT NULL,
  `Item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `description` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`Menuid`, `RestaurantID`, `Item`, `price`, `description`) VALUES
(1, 1, 'cheese burger', 400, 'salase , tomato, chedar cheese, 100g meat'),
(2, 1, 'double chicken', 500, 'salase , tomato, chedar cheese, crispy chicken'),
(3, 1, 'double chicken', 500, 'salase , tomato, chedar cheese, crispy chicken'),
(4, 1, 'Classic Cheeseburger', 450, 'Beef patty, cheddar cheese, pickles, lettuce, tomato'),
(5, 1, 'BBQ Chicken Wrap', 350, 'Grilled chicken, BBQ sauce, lettuce, wrapped in tortilla'),
(6, 1, 'Loaded Fries', 300, 'Fries topped with cheese, jalapenos, and bacon bits'),
(7, 1, 'Chicken Caesar Salad', 450, 'Grilled chicken, Caesar dressing, croutons, Parmesan cheese'),
(8, 1, 'Tuna Melt Sandwich', 400, 'Tuna, melted Swiss cheese, pickles, and special sauce'),
(9, 1, 'Margarita Pizza', 600, 'Tomato sauce, mozzarella, fresh basil leaves'),
(10, 1, 'Chocolate Milkshake', 250, 'Rich chocolate flavor, whipped cream topping'),
(11, 1, 'Grilled Fish Taco', 350, 'Grilled fish, lime dressing, slaw, soft taco shell'),
(12, 1, 'Spicy Chicken Burger', 550, 'Spicy sauce, lettuce, tomato, crispy chicken patty'),
(13, 1, 'Veggie Delight', 400, 'Fresh vegetables, avocado, cheese, special sauce');

-- --------------------------------------------------------

--
-- Table structure for table `restaurants`
--

CREATE TABLE `restaurants` (
  `RestaurantID` int(11) NOT NULL,
  `RestaurantName` varchar(100) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `ImageURL` varchar(255) DEFAULT NULL,
  `RegionName` varchar(50) DEFAULT NULL,
  `CategoryName` varchar(50) DEFAULT NULL,
  `OpeningTime` time DEFAULT NULL,
  `ClosingTime` time DEFAULT NULL,
  `Location` varchar(255) DEFAULT NULL,
  `priceRange` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `restaurants`
--

INSERT INTO `restaurants` (`RestaurantID`, `RestaurantName`, `Phone`, `Description`, `ImageURL`, `RegionName`, `CategoryName`, `OpeningTime`, `ClosingTime`, `Location`, `priceRange`) VALUES
(1, 'drunch', '+213 31 850000', 'Famous fast food chain offering burgers, fries, and milkshakes.', 'https://media-cdn.tripadvisor.com/media/photo-s/0c/8f/b7/ef/jannah-restaurant-terrace.jpg', 'Constantine', 'FastFood', '10:00:00', '23:00:00', 'https://www.google.dz/maps/place/Drunch/@36.3625574,6.6080098,17z/data=!3m1!4b1!4m6!3m5!1s0x12f177000036c547:0xcfbbf48542ec62f2!8m2!3d36.3625574!4d6.6080098!16s%2Fg%2F11vlxwjxjt?entry=ttu&g_ep=EgoyMDI0MTIxMS4wIKXMDSoASAFQAw%3D%3D', 3),
(3, 'YFC ', '+213 31 950000', 'Known for fried chicken and sides.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRapwucs0gRZSxhw-7jYKqXAfEWOhzwpeGhcg&s', 'Constantine', 'FastFood', '09:00:00', '23:00:00', 'https://www.google.com/maps/place/KFC+Constantine', 2),
(4, 'la mega pizza', '+213 31 762345', 'national chain serving a variety of pizzas and tacos.', 'https://th.bing.com/th/id/OIP.u84P80rGLuExpAocu2GcPgHaFa?rs=1&pid=ImgDetMain', 'Constantine', 'FastFood', '10:00:00', '22:00:00', 'https://www.google.com/maps/place/Pizza+Hut+Constantine', 1),
(5, 'pablo', '+213 31 790000', 'Famous for sandwiches.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3BLddD9jje_7B5lULFi_lUInLmL4_VoyHcg&s', 'Constantine', 'FastFood', '10:00:00', '23:00:00', 'https://www.google.com/maps/place/Subway+Constantine', 3),
(6, 'Le Palais des Saveurs', '+213 31 761234', 'A restaurant offering traditional Algerian dishes with a great ambiance.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqA0vW_7EtPPAkf6p8BDN5izJOG8ML_B7Rkw&s', 'Constantine', 'Traditional', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/Le+Palais+des+Saveurs', 1),
(7, 'Restaurant El Badr', '+213 31 751789', 'Traditional Algerian cuisine with an emphasis on local flavors.', 'https://www.pagesjaunes.fr/media/agc/crop/250x250/78/8e/5c/00/00/fc/38/4f/92/e7/60c7788e5c0000fc384f92e7/60c7788e5c0000fc384f92e8.png?v=2', 'Constantine', 'Traditional', '11:00:00', '23:00:00', 'https://www.google.com/maps/place/Restaurant+El+Badr', 3),
(8, 'La Table de Constantine', '+213 31 761234', 'Fine dining offering a variety of international and local dishes.', 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/18/43/1f/85/img-20190710-202448-largejpg.jpg?w=600&h=400&s=1', 'Constantine', 'Traditional', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/La+Table+de+Constantine', 3),
(9, 'Dar El-Medina', '+213 31 790000', 'Traditional Algerian meals in an elegant setting.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR55vd92Cuuyfw4tEhM0PXOkok-M77H1epnyA&s', 'Constantine', 'Traditional', '10:00:00', '22:00:00', 'https://www.google.com/maps/place/Dar+El-Medina', 2),
(10, 'La Pergola', '+213 31 763567', 'Known for gourmet meals and exceptional service with a panoramic view of the city.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7XPemyOT1ckq8-z-nkh-7dXmC0cFusKC1kw&s', 'Constantine', 'Fine Dining', '11:00:00', '23:00:00', 'https://www.google.com/maps/place/La+Pergola', 3),
(11, 'Restaurant Le Cèdre', '+213 31 762000', 'Offering a fusion of traditional and Mediterranean cuisine.', 'https://i.insider.com/595a9ccc298d4aec278b4649?width=700', 'Constantine', 'Fine Dining', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/Restaurant+Le+Cèdre', 1),
(12, 'Le Grand Hotel Restaurant', '+213 31 750000', 'Upscale dining experience with French and Algerian influences.', 'https://pix10.agoda.net/hotelImages/1062279/0/75a09593cc6fc98278a62cfa4776a6b9.jpg?ca=7&ce=1&s=414x232', 'Constantine', 'Fine Dining', '13:00:00', '23:00:00', 'https://www.google.com/maps/place/Le+Grand+Hotel+Restaurant', 3),
(13, 'Le Riad', '+213 31 760123', 'Mediterranean restaurant known for its grilled fish and seafood dishes.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZPY97ol_K6sHo7ZFHOVPIQ8ecfLfilGiRbg&s', 'Constantine', 'Fine Dining', '11:00:00', '00:00:00', 'https://www.google.com/maps/place/Le+Riad', 2),
(14, 'Pizzeria La Scala', '+213 31 741235', 'Known for authentic Italian pizzas with a local twist in Constantine.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmnRZET2DqbU9UqD6MQ81QfJMv6NtZYP7hNg&s', 'Constantine', 'Pizzeria', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/Pizzeria+La+Scala', 2),
(15, 'Pizza Express Constantine', '+213 31 759012', 'Famous for pizza and pasta, with vegetarian options.', 'https://static.vecteezy.com/ti/photos-gratuite/t2/24028267-entier-un-barbecue-poulet-pizza-sur-en-bois-coupeur-planche-pour-vite-nourriture-et-pret-a-manger-concept-generatif-ai-photo.jpg', 'Constantine', 'Pizzeria', '10:00:00', '22:00:00', 'https://www.google.com/maps/place/Pizza+Express+Constantine', 1),
(16, 'Café El Medina', '+213 31 800654', 'Cozy spot for coffee and desserts in the heart of Constantine.', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMSEhUSExMVFhUXGB4YGRgYGRgaGBobHx4YGBgYHxsYHSggGBolHhoaITEhJSkrLi4uHSAzODMtNygtLisBCgoKDg0OGxAQGy8mICUrLS0tLS0wLjc1LS0vLS8tLTAvLS0tLS0tNS0wLS0vLS0rLS0tLS0tLS0tLS0vLS0tLf/AABEIAMIBAwMBIgACEQEDEQH/', 'Constantine', 'Cafeteria', '08:00:00', '20:00:00', 'https://www.google.com/maps/place/Café+El+Medina', 2),
(17, 'Apex', '+213 31 750123', 'Famous for coffee, pastries, and cakes, ideal for a relaxing break.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSP7hkNTFwLIO5FKL8NGQCetAMqFquSXXxIYg&s', 'Constantine', 'Cafeteria', '09:00:00', '21:00:00', 'https://www.google.com/maps/place/Café+de+Paris', 2),
(18, 'Le Castillet', '+213 21 765432', 'Mediterranean cuisine with a mix of local flavors.', 'https://www.example.com/images/le_castillet.jpg', 'Algiers', 'Fine Dining', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/Le+Castillet', 2),
(19, 'La Brasserie', '+213 21 760432', 'French-inspired brasserie with a full menu of traditional dishes.', 'https://www.example.com/images/la_brasserie.jpg', 'Algiers', 'Fine Dining', '11:00:00', '23:00:00', 'https://www.google.com/maps/place/La+Brasserie', 1),
(20, 'La Plage', '+213 41 123456', 'Seafood and Mediterranean dishes, located by the sea.', 'https://www.example.com/images/la_plage.jpg', 'Oran', 'Fine Dining', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/La+Plage', 3),
(21, 'Le Jardin d\'El Menzah', '+213 41 654321', 'A mix of traditional and modern Algerian dishes.', 'https://www.example.com/images/le_jardin.jpg', 'Oran', 'Fine Dining', '11:00:00', '23:00:00', 'https://www.google.com/maps/place/Le+Jardin+d\'El+Menzah', 3),
(22, 'Café Restaurant La Fontaine', '+213 43 321432', 'Café offering breakfast and lunch in a quiet atmosphere.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZpBVXv4X4dUfEftw_SNeqzQnyp7r3IkxJiQ&s', 'Tlemcen', 'Cafeteria', '08:00:00', '20:00:00', 'https://www.google.com/maps/place/Café+Restaurant+La+Fontaine', 3),
(23, 'Le Gourmet', '+213 43 654123', 'Known for traditional Tlemcenian dishes with modern flair.', 'https://www.example.com/images/le_gourmet.jpg', 'Tlemcen', 'Fine Dining', '11:00:00', '23:00:00', 'https://www.google.com/maps/place/Le+Gourmet', 1),
(24, 'Restaurant El Chabbi', '+213 38 123123', 'A famous spot for local seafood dishes.', 'https://www.example.com/images/el_chabbi.jpg', 'Annaba', 'Fine Dining', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/Restaurant+El+Chabbi', 1),
(25, 'Café des Arts', '+213 38 654321', 'Café known for its artistic ambiance and pastries.', 'https://www.example.com/images/cafe_arts.jpg', 'Annaba', 'Cafeteria', '09:00:00', '20:00:00', 'https://www.google.com/maps/place/Café+des+Arts', 1),
(26, 'Restaurant Alia', '+213 36 123654', 'A traditional Algerian restaurant offering a range of local dishes.', 'https://www.example.com/images/alia_restaurant.jpg', 'Setif', 'Fine Dining', '11:00:00', '23:00:00', 'https://www.google.com/maps/place/Restaurant+Alia', 1),
(27, 'Pizzeria La Milano', '+213 36 654987', 'Known for Italian pizzas and pasta.', 'https://www.example.com/images/pizzeria_milano.jpg', 'Setif', 'Pizzeria', '12:00:00', '22:00:00', 'https://www.google.com/maps/place/Pizzeria+La+Milano', 2),
(28, 'McDonald\'s Oran', '+213 41 751000', 'Famous for burgers, fries, and soft drinks, ideal for a quick meal.', 'https://www.mcdonalds.com/images/mcdonalds.jpg', 'Oran', 'FastFood', '09:00:00', '23:00:00', 'https://www.google.com/maps/place/McDonald\'s+Oran', 2),
(29, 'KFC Oran', '+213 41 752300', 'Known for fried chicken and fast food menu.', 'https://www.kfc.com/images/kfc_oran.jpg', 'Oran', 'FastFood', '10:00:00', '22:00:00', 'https://www.google.com/maps/place/KFC+Oran', 1),
(30, 'Pizza Hut Oran', '+213 41 759500', 'Pizza chain offering a variety of pizzas and sides.', 'https://www.pizzahut.com/images/pizzahut_oran.jpg', 'Oran', 'FastFood', '10:00:00', '23:00:00', 'https://www.google.com/maps/place/Pizza+Hut+Oran', 3),
(31, 'Le Palais Algérien', '+213 21 741234', 'Traditional Algerian restaurant with a variety of local dishes.', 'https://www.palaisalgerien.com/images/palais.jpg', 'Algiers', 'Traditional', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/Le+Palais+Algérien', 2),
(32, 'Restaurant El Chlef', '+213 21 760987', 'Traditional dishes served in a rustic setting.', 'https://www.example.com/images/el_chlef.jpg', 'Algiers', 'Traditional', '11:00:00', '22:00:00', 'https://www.google.com/maps/place/Restaurant+El+Chlef', 1),
(33, 'Chez Ziani', '+213 21 765432', 'Known for couscous and grilled meats in a cozy atmosphere.', 'https://www.example.com/images/chez_ziani.jpg', 'Algiers', 'Traditional', '10:00:00', '23:00:00', 'https://www.google.com/maps/place/Chez+Ziani', 3),
(34, 'Restaurant El Samra', '+213 41 741000', 'A beautiful restaurant offering local and Mediterranean seafood dishes.', 'https://www.examples.com/images/el_samra.jpg', 'Oran', 'Fine Dining', '11:00:00', '23:00:00', 'https://www.google.com/maps/place/Restaurant+El+Samra', 3),
(35, 'La Villa', '+213 41 732000', 'French-Algerian fusion cuisine in a stylish setting.', 'https://www.example.com/images/la_villa_oran.jpg', 'Oran', 'Fine Dining', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/La+Villa+Oran', 3),
(36, 'Le Riad Oran', '+213 41 750234', 'Traditional Algerian meals served in an upscale environment.', 'https://www.example.com/images/le_riad_oran.jpg', 'Oran', 'Fine Dining', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/Le+Riad+Oran', 2),
(37, 'Pizzeria La Belle', '+213 43 432123', 'Authentic Italian pizza and pasta dishes.', 'https://www.example.com/images/pizzeria_belle.jpg', 'Tlemcen', 'Pizzeria', '10:00:00', '22:00:00', 'https://www.google.com/maps/place/Pizzeria+La+Belle', 3),
(38, 'Pizza King Tlemcen', '+213 43 451234', 'Well-known for its variety of pizzas and fast service.', 'https://www.example.com/images/pizza_king.jpg', 'Tlemcen', 'Pizzeria', '11:00:00', '23:00:00', 'https://www.google.com/maps/place/Pizza+King+Tlemcen', 2),
(39, 'Café El Malek', '+213 38 770123', 'A perfect spot for coffee and snacks, with an outdoor seating area.', 'https://www.example.com/images/cafe_elmalek.jpg', 'Annaba', 'Cafeteria', '08:00:00', '21:00:00', 'https://www.google.com/maps/place/Café+El+Malek', 3),
(40, 'Café Central Annaba', '+213 38 765432', 'Specializes in pastries, coffee, and light meals.', 'https://www.example.com/images/cafe_central.jpg', 'Annaba', 'Cafeteria', '09:00:00', '20:00:00', 'https://www.google.com/maps/place/Café+Central+Annaba', 1),
(41, 'Chicken Grill Setif', '+213 36 761234', 'Fast food restaurant offering grilled chicken and sandwiches.', 'https://www.example.com/images/chicken_grill.jpg', 'Setif', 'FastFood', '10:00:00', '22:00:00', 'https://www.google.com/maps/place/Chicken+Grill+Setif', 3),
(42, 'Café Fast Setif', '+213 36 752010', 'Quick bites and snacks with a focus on sandwiches and wraps.', 'https://www.example.com/images/cafe_fast_setif.jpg', 'Setif', 'FastFood', '10:00:00', '23:00:00', 'https://www.google.com/maps/place/Café+Fast+Setif', 2),
(43, 'Chez Brahim', '+213 38 789654', 'Traditional Algerian meals with a local twist.', 'https://www.example.com/images/chez_brahim.jpg', 'Annaba', 'Traditional', '12:00:00', '22:00:00', 'https://www.google.com/maps/place/Chez+Brahim', 2),
(44, 'Le Souk', '+213 38 754321', 'Traditional food served in a beautiful market-style atmosphere.', 'https://www.example.com/images/le_souk.jpg', 'Annaba', 'Traditional', '11:00:00', '23:00:00', 'https://www.google.com/maps/place/Le+Souk+Annaba', 3),
(45, 'Al Amir', '+213 43 434565', 'A high-end restaurant serving a variety of Mediterranean dishes.', 'https://www.example.com/images/al_amir.jpg', 'Tlemcen', 'Fine Dining', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/Al+Amir+Tlemcen', 1),
(46, 'Restaurant Le Sultane', '+213 43 455432', 'Known for its luxurious setting and rich traditional dishes.', 'https://www.example.com/images/le_sultane.jpg', 'Tlemcen', 'Fine Dining', '13:00:00', '00:00:00', 'https://www.google.com/maps/place/Restaurant+Le+Sultane', 1),
(47, 'Pizzeria Deliziosa', '+213 41 761234', 'Authentic Italian pizza in the heart of Oran.', 'https://www.example.com/images/pizzeria_deliziosa.jpg', 'Oran', 'Pizzeria', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/Pizzeria+Deliziosa', 2),
(48, 'Pizza Napoli', '+213 41 750987', 'Famous for its thin-crust pizzas and seafood topping.', 'https://www.example.com/images/pizza_napoli.jpg', 'Oran', 'Pizzeria', '11:00:00', '22:00:00', 'https://www.google.com/maps/place/Pizza+Napoli+Oran', 2),
(49, 'Burger King Algiers', '+213 21 542000', 'Famous for flame-grilled burgers, fries, and shakes.', 'https://www.burgerking.com/images/burgerking.jpg', 'Algiers', 'FastFood', '10:00:00', '23:00:00', 'https://www.google.com/maps/place/Burger+King+Algiers', 2),
(50, 'Snack El Waha', '+213 21 569200', 'Fast food serving burgers, sandwiches, and local snacks.', 'https://www.example.com/images/snack_elwaha.jpg', 'Algiers', 'FastFood', '08:00:00', '22:00:00', 'https://www.google.com/maps/place/Snack+El+Waha+Algiers', 2),
(51, 'Tasty Burger', '+213 21 584300', 'Burger joint with a variety of sides and fast food items.', 'https://www.example.com/images/tasty_burger.jpg', 'Algiers', 'FastFood', '09:00:00', '23:00:00', 'https://www.google.com/maps/place/Tasty+Burger+Algiers', 2),
(52, 'Le Safir Oran', '+213 41 722567', 'Traditional Algerian meals served in a family-friendly atmosphere.', 'https://www.example.com/images/le_safir_oran.jpg', 'Oran', 'Traditional', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/Le+Safir+Oran', 3),
(53, 'Restaurant La Medina', '+213 41 734890', 'A blend of Mediterranean and Algerian dishes.', 'https://www.example.com/images/la_medina_oran.jpg', 'Oran', 'Traditional', '11:00:00', '22:00:00', 'https://www.google.com/maps/place/Restaurant+La+Medina+Oran', 2),
(54, 'Chez Ahmed', '+213 41 758321', 'Known for its couscous and traditional stews.', 'https://www.example.com/images/chez_ahmed.jpg', 'Oran', 'Traditional', '10:00:00', '23:00:00', 'https://www.google.com/maps/place/Chez+Ahmed+Oran', 2),
(55, 'La Table de Constantine', '+213 31 754321', 'Upscale dining with traditional Constantine dishes and a modern twist.', 'https://www.example.com/images/la_table_constantine.jpg', 'Constantine', 'Fine Dining', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/La+Table+de+Constantine', 1),
(56, 'Restaurant Djemila', '+213 31 721098', 'Famous for its grilled meats and Mediterranean-inspired dishes.', 'https://www.example.com/images/restaurant_djemila.jpg', 'Constantine', 'Fine Dining', '13:00:00', '22:00:00', 'https://www.google.com/maps/place/Restaurant+Djemila+Constantine', 2),
(57, 'Le Restaurant El Hada', '+213 31 730456', 'Known for its seafood and traditional Constantine specialties.', 'https://www.example.com/images/el_hada_constantine.jpg', 'Constantine', 'Fine Dining', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/Le+Restaurant+El+Hada+Constantine', 2),
(58, 'Pizzeria Algiers', '+213 21 758654', 'Traditional Italian pizza with fresh ingredients and a cozy ambiance.', 'https://www.example.com/images/pizzeria_algiers.jpg', 'Algiers', 'Pizzeria', '12:00:00', '22:00:00', 'https://www.google.com/maps/place/Pizzeria+Algiers', 1),
(59, 'Pizza Mama', '+213 21 753109', 'Known for its large selection of pizza toppings and family-friendly setting.', 'https://www.example.com/images/pizza_mama.jpg', 'Algiers', 'Pizzeria', '11:00:00', '23:00:00', 'https://www.google.com/maps/place/Pizza+Mama+Algiers', 1),
(60, 'Café le 7', '+213 41 720765', 'A quiet café with a wide range of pastries and fresh coffee.', 'https://www.example.com/images/cafe_le7.jpg', 'Oran', 'Cafeteria', '08:00:00', '20:00:00', 'https://www.google.com/maps/place/Café+Le+7+Oran', 1),
(61, 'Café El Jardin', '+213 41 737823', 'Charming café with outdoor seating, perfect for coffee and desserts.', 'https://www.example.com/images/cafe_jardin_oran.jpg', 'Oran', 'Cafeteria', '09:00:00', '22:00:00', 'https://www.google.com/maps/place/Café+El+Jardin+Oran', 2),
(62, 'Fritissimo Constantine', '+213 31 755321', 'Serving quick fried foods and snacks, with a local twist.', 'https://www.example.com/images/fritissimo_constantine.jpg', 'Constantine', 'FastFood', '10:00:00', '23:00:00', 'https://www.google.com/maps/place/Fritissimo+Constantine', 3),
(63, 'Snack Ahmed', '+213 31 741012', 'Popular for sandwiches and local snacks, quick and tasty food.', 'https://www.example.com/images/snack_ahmed.jpg', 'Constantine', 'FastFood', '09:00:00', '21:00:00', 'https://www.google.com/maps/place/Snack+Ahmed+Constantine', 3),
(64, 'Le Gourmet Setif', '+213 36 761234', 'A fine dining experience offering a variety of international and local dishes.', 'https://www.example.com/images/le_gourmet_setif.jpg', 'Setif', 'Fine Dining', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/Le+Gourmet+Setif', 3),
(65, 'Al Basha Setif', '+213 36 770453', 'Traditional Algerian dishes in a cozy, family-friendly environment.', 'https://www.example.com/images/al_basha_setif.jpg', 'Setif', 'Fine Dining', '11:00:00', '22:00:00', 'https://www.google.com/maps/place/Al+Basha+Setif', 3),
(66, 'Restaurant El Rayhan', '+213 41 748763', 'Traditional meals served with Algerian hospitality.', 'https://www.example.com/images/el_rayhan_oran.jpg', 'Oran', 'Traditional', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/Restaurant+El+Rayhan+Oran', 2),
(67, 'Darna Restaurant', '+213 41 757856', 'A traditional Algerian restaurant specializing in stews and couscous.', 'https://www.example.com/images/darna_restaurant.jpg', 'Oran', 'Traditional', '11:00:00', '22:00:00', 'https://www.google.com/maps/place/Darna+Restaurant+Oran', 3),
(68, 'La Pizzeria Tlemcen', '+213 43 741234', 'Authentic Italian pizza with a variety of toppings.', 'https://www.example.com/images/la_pizzeria_tlemcen.jpg', 'Tlemcen', 'Pizzeria', '11:00:00', '22:00:00', 'https://www.google.com/maps/place/La+Pizzeria+Tlemcen', 2),
(69, 'Pizzeria La Dolce Vita', '+213 43 735600', 'Pizzeria specializing in wood-fired pizzas.', 'https://www.example.com/images/dolce_vita_tlemcen.jpg', 'Tlemcen', 'Pizzeria', '12:00:00', '23:00:00', 'https://www.google.com/maps/place/Pizzeria+La+Dolce+Vita+Tlemcen', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `email` varchar(30) NOT NULL,
  `username` varchar(10) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `location` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`email`, `username`, `password`, `image`, `location`) VALUES
('han@gmail.com', 'hanbin', '$2y$10$FSySJH9G92fzuVFBE1z2yeNK4vaVoRV/ZcjVLYEUpCMcDpdURSHIq', NULL, NULL),
('mayar@gmail.com', 'mayar', '$2y$10$zjx2DpweZ5F0KyZbWhqJ0uHTmVH/t0Obb18qUrZ59OhtE2hq0WSIu', 'https://images-cdn.ubuy.co.in/639c11f3d12ce3409f3edc8c-6-cute-small-baby-doll-little-dolls.jpg', 'Constantine'),
('nor@gmail.com', 'norhane', '$2y$10$YP8qr91JcuIVdUoOYIZrjegvmsxJUvbr2D8Zim2f4KE777GuCuQri', NULL, ''),
('rah@gmail.com', 'rahma', '$2y$10$HwxPpGvChVIJseOb0Ex.yO95z25NpHlIno0G1TjAHj4VMV/8m3hgq', NULL, '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`CommentID`),
  ADD KEY `email` (`email`),
  ADD KEY `RestaurantID` (`RestaurantID`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`likeID`),
  ADD KEY `email` (`email`),
  ADD KEY `RestaurantID` (`RestaurantID`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`Menuid`),
  ADD KEY `RestaurantID` (`RestaurantID`);

--
-- Indexes for table `restaurants`
--
ALTER TABLE `restaurants`
  ADD PRIMARY KEY (`RestaurantID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `CommentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `likeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `Menuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `restaurants`
--
ALTER TABLE `restaurants`
  MODIFY `RestaurantID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`RestaurantID`) REFERENCES `restaurants` (`RestaurantID`) ON DELETE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`RestaurantID`) REFERENCES `restaurants` (`RestaurantID`) ON DELETE CASCADE;

--
-- Constraints for table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`RestaurantID`) REFERENCES `restaurants` (`RestaurantID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
