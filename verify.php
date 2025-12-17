<?php
error_log("Received GET data - name: " . ($_GET['name'] ?? 'Not Provided') . ", manufacturer: " . ($_GET['manufacturer'] ?? 'Not Provided'));

$servername = "localhost";
$username = "root";
$password = "root";
$dbname = "qrx_db"; 

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$medicineName = $_GET['name'] ?? '';
$manufacturer = $_GET['manufacturer'] ?? '';

if (empty($medicineName) || empty($manufacturer)) {
    echo json_encode(['status' => 'Invalid Input']);
    exit;
}

$sql = "SELECT * FROM medicines WHERE name = ? AND manufacturer = ?";
$stmt = $conn->prepare($sql);

if ($stmt === false) {
    die("Error preparing query: " . $conn->error);
}

$stmt->bind_param("ss", $medicineName, $manufacturer);
$stmt->execute();

$result = $stmt->get_result();

error_log("Number of rows returned: " . $result->num_rows);

if ($result->num_rows > 0) {
    $medicine = $result->fetch_assoc();
    echo json_encode([
        'status' => $medicine['status'],
        'name' => $medicine['name'],
        'manufacturer' => $medicine['manufacturer'],
        'batch' => $medicine['batch']
    ]);
} else {
    echo json_encode(['status' => 'Not Found']);
}

$stmt->close();
$conn->close();
?>
