<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
  <div class="container mt-5">
    <form id="myform" method="post" action="">
      
      <!-- 제목 -->
      <div class="row justify-content-center mb-4">
        <div class="col-8 text-center">
          <h2><b>회원가입</b></h2>
        </div>
      </div>
      
      <!-- 아이디 -->
      <div class="form-group row">
        <label for="mid" class="col-sm-3 col-form-label text-right">아이디</label>
        <div class="col-sm-8">
          <input type="text" class="form-control" id="mid" name="mid" required>
        </div>
      </div>
      
      <!-- 비밀번호 -->
      <div class="form-group row">
        <label for="pwd" class="col-sm-3 col-form-label text-right">비밀번호</label>
        <div class="col-sm-8">
          <input type="password" class="form-control" id="pwd" name="pwd" required>
        </div>
      </div>
      
      <!-- 이름 -->
      <div class="form-group row">
        <label for="name" class="col-sm-3 col-form-label text-right">이름</label>
        <div class="col-sm-8">
          <input type="text" class="form-control" id="name" name="name" required>
        </div>
      </div>
      
      <!-- 닉네임 -->
      <div class="form-group row">
        <label for="nickname" class="col-sm-3 col-form-label text-right">닉네임</label>
        <div class="col-sm-8">
          <input type="text" class="form-control" id="nickname" name="nickname" required>
        </div>
      </div>
      
      <!-- 전화번호 -->
      <div class="form-group row">
        <label class="col-sm-3 col-form-label text-right">전화번호</label>
        <div class="col-sm-2">
          <select class="form-control" id="tel1" name="tel1" required>
            <option selected>지역번호</option>
            <option value="043">043</option>
            <option value="02">02</option>
          </select>
        </div>
        <div class="col-sm-2">
          <select class="form-control" id="tel2" name="tel2" required>
            <option selected>국번</option>
            <option value="123">123</option>
            <option value="456">456</option>
          </select>
        </div>
        <div class="col-sm-2">
          <select class="form-control" id="tel3" name="tel3" required>
            <option selected>전화번호</option>
            <option value="321">321</option>
            <option value="654">654</option>
          </select>
        </div>
      </div>
      
      <!-- 이메일 -->
      <div class="form-group row">
        <label class="col-sm-3 col-form-label text-right">이메일</label>
        <div class="col-sm-3">
          <input type="text" class="form-control" id="email1" name="email1" required>
        </div>
        <div class="col-sm-1 text-center">
          <span>@</span>
        </div>
        <div class="col-sm-3">
          <select class="form-control" id="email2" name="email2" required>
            <option value="naver.com">naver.com</option>
            <option value="daum.net">daum.net</option>
          </select>
        </div>
      </div>

      <!-- 제출 버튼 -->
      <div class="row justify-content-center">
        <button type="submit" class="btn btn-primary">제출</button>
      </div>

    </form>
  </div>

  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
