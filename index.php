<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: *');
header('Access-Control-Allow-Methods: *');
header('Access-Control-Allow-Credentials: true');
//header('Content-type: json/application');

$connect = mysqli_connect('127.0.0.1:3306', 'mysql', 'mysql', 'connection');

$method = $_SERVER['REQUEST_METHOD'];

$type = $_GET['q'];

if ($method === 'GET') {
    if (!$type) { //начальная загрузка
        $cities = mysqli_query($connect, "SELECT * FROM `cities`");
        $causes = mysqli_query($connect, "SELECT * FROM `cause-call`");
        $causesClose = mysqli_query($connect, "SELECT * FROM `cause-close`");
        if ($cities && $causes && $causesClose) {

            while ($city = mysqli_fetch_assoc($cities)) {
                $cities_list[] = $city;
            }

            while ($cause = mysqli_fetch_assoc($causes)) {
                $causes_list[] = $cause;
            }

            while ($causeClose = mysqli_fetch_assoc($causesClose)) {
                $causesClose_list[] = $causeClose;
            }

            $data = ['cities' => $cities_list, 'causes' => $causes_list, 'causesClose' => $causesClose_list];
            echo json_encode($data); { //причины звонка и города
            }
        }
        return;
    } elseif ($type === 'confirmation') {
        $id = $_GET['id']; //принимаем айди пользователя
        if (!mysqli_query($connect, "UPDATE request SET active = 0 WHERE id = '$id'")) {
            echo ("Сообщение ошибки: %s\n" . mysqli_error($connect));
        }
        return;
    } elseif ($type === 'close') {
        $id = intval($_GET['id']); //принимаем айди пользователя
        $causeClose = intval($_GET['causeClose']);
        if (!mysqli_query($connect, "UPDATE request SET active = 0, `cause-close_id` = $causeClose WHERE id = '$id'")) {
            echo ("Сообщение ошибки: %s\n" . mysqli_error($connect));
        }
        return;
    }
} elseif ($method === 'POST') {
    $_POST = json_decode(file_get_contents('php://input'), true);
    if (!$type) { //отправка формы 
        $city_id = intval($_POST['city']);
        $fio = $_POST['fio'];
        $address = $_POST['address'];
        $cause_id = intval($_POST['cause']);
        $comment = $_POST['comment'];
        $tel = $_POST['tel'];
        $tel_additional = $_POST['tel-additional'];
        if (!mysqli_query($connect, "INSERT INTO request (`city_id`,`fio`,`address`,`cause_id`,`comment`,`tel`,`tel-additional`) VALUES ('$city_id','$fio','$address', $cause_id,'$comment','$tel', '$tel_additional')")) {
            echo ("Сообщение ошибки: %s\n" . mysqli_error($connect));
        }
        $userId = mysqli_insert_id($connect);
        $suggestions = mysqli_query($connect, "SELECT provider.name, provider.id, tariff.tariffName, tariff.price, services.serviceName, tariff.id as tariff_id, services.id as services_id FROM `provider` 
        LEFT JOIN `tariff` ON provider.id = provider_id
        LEFT JOIN `tariff_services` ON tariff.id = tariff_services.tariff_id
        LEFT JOIN `services` ON services.id = tariff_services.services_id
        ");
        while ($fuck = mysqli_fetch_assoc($suggestions)) {
            $suggestions_list[] = $fuck;
        }
        $list = [];
        foreach ($suggestions_list as $key => $value) {
            if (!array_key_exists($value['id'], $list)) {
                $list[$value['id']] = [];
            }
            $list[$value['id']]['provider'] = $value['name'];
            $list[$value['id']]['id'] = $value['id'];
            if (!array_key_exists('tariffs', $list[$value['id']])) {
                $list[$value['id']]['tariffs'] = [];
            }
            $list[$value['id']]['tariffs'][$value['tariff_id']]['name'] = $value['tariffName'];
            $list[$value['id']]['tariffs'][$value['tariff_id']]['id'] = $value['tariff_id'];
            $list[$value['id']]['tariffs'][$value['tariff_id']]['price'] = $value['price'];
            $list[$value['id']]['tariffs'][$value['tariff_id']]['services'][$value['services_id']] = $value['serviceName'];
        }
        echo json_encode(['userId' => $userId, 'suggestions' => $list]);
        return; //возвращаем юзер айди и провайдеров с тарифами
    } elseif ($type === 'provider') {
        $provider = intval($_POST['provider']);
        $tariff = intval($_POST['tariff']);
        $id = intval($_POST['userId']);
        if (!mysqli_query($connect, "UPDATE request SET provider_id = '$provider',tariff_id = '$tariff' WHERE id = '$id'")) {
            echo ("Сообщение ошибки: %s\n" . mysqli_error($connect));
        }
        return; //не возвращаем данные
    }
}
