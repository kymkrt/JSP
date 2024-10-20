<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Example</title>
    <script>
        function showSelectedValue() {
            // 선택된 옵션의 값을 가져옵니다.
            let img = document.myform.sel.value;
            alert("Selected value: " + img); // 선택된 값 알림
            document.getElementById("demo").innerHTML = "You selected: " + img; // 선택된 값을 페이지에 표시
        }
    </script>
</head>
<body>

<form name="myform">
    <label for="sel">Choose an option:</label>
    <select name="sel" id="sel" onchange="showSelectedValue()"> <!-- onchange 이벤트 사용 -->
        <option value="Image1">Image 1</option>
        <option value="Image2">Image 2</option>
        <option value="Image3">Image 3</option>
    </select>
</form>

<p id="demo"></p> <!-- 선택된 값이 표시될 영역 -->

</body>
</html>
