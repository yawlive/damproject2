<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include("connect.php");

$region = isset($_GET['region']) ? $_GET['region'] : '';


if (!empty($region)) {
    $stmt = $con->prepare("SELECT r.* , COALESCE(SUM(ratings.rate), 0) as rating FROM restaurants r 
                           left join ratings on r.RestaurantID=Ratings.RestaurantID
                           WHERE   lower(r.RegionName) = ? group by RestaurantID  ");

    $stmt->bind_param("s", $region);
    $stmt->execute();
    $result = $stmt->get_result();
    $restaurants = [];

    while ($row = $result->fetch_assoc()) {
        $restaurants[] = $row;
    }

    echo json_encode($restaurants);
    $stmt->close();
} else {
    echo json_encode(["error" => "region parameter is missing"]);
}

$con->close();
?>
