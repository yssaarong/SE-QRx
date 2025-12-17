<?php
// Enable error logging for debugging
error_log("Received GET data - name: " . ($_GET['name'] ?? 'Not Provided') . ", manufacturer: " . ($_GET['manufacturer'] ?? 'Not Provided'));

$servername = "localhost";
$username = "root"; // Your database username
$password = "root"; // Your database password
$dbname = "qrx_db"; // Your database name

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get data from GET request
$medicineName = $_GET['name'] ?? '';  // Get 'name' from GET parameters
$manufacturer = $_GET['manufacturer'] ?? '';  // Get 'manufacturer' from GET parameters

// Check if the parameters are empty
if (empty($medicineName) || empty($manufacturer)) {
    echo json_encode(['status' => 'Invalid Input']);
    exit;
}

// SQL query to find the medicine in the database
$sql = "SELECT * FROM medicines WHERE name = ? AND manufacturer = ?";
$stmt = $conn->prepare($sql);

// Check if the query was prepared correctly
if ($stmt === false) {
    die("Error preparing query: " . $conn->error);
}

// Bind parameters and execute
$stmt->bind_param("ss", $medicineName, $manufacturer);
$stmt->execute();

// Get the result
$result = $stmt->get_result();

// Log the result count
error_log("Number of rows returned: " . $result->num_rows);

if ($result->num_rows > 0) {
    // Medicine found
    $medicine = $result->fetch_assoc();
    echo json_encode([
        'status' => $medicine['status'],
        'name' => $medicine['name'],
        'manufacturer' => $medicine['manufacturer'],
        'batch' => $medicine['batch']
    ]);
} else {
    // Medicine not found
    echo json_encode(['status' => 'Not Found']);
}

// Close the statement and connection
$stmt->close();
$conn->close();
?>
