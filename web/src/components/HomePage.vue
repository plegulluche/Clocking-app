<template>
  <div class="background">
    <div class="globalContainer">
      <div class="titles">
        <img src="../assets/images/Batman-Logo.png" alt="batmanLogo" class="bat2" />
        <h3 class="titleString">Time manager</h3>
        <h2 class="titleString">Track your time</h2>
      </div>
      <div class="container">
        <div class="firstDigits">
          <h1>12</h1>
        </div>
        <div class="firstDigits">
          <h1>25</h1>
        </div>
        <div class="containerDigit">
          <h1>4</h1>
          <h1 class="second">4</h1>
          <h1 class="third">5</h1>
          <img src="../assets/images/Batman-Logo.png" alt="batmanLogo" class="bat1" />
        </div>
        <div class="containerButton">
          <RouterLink to="/login" class="button">
            <el-button class="btn" type="danger" round>Connection</el-button>
          </RouterLink>

          <RouterLink to="/Register" class="button">
            <el-button type="danger" round>Create an account</el-button>
          </RouterLink>
        </div>
      </div>
      <div class="containerSecond">
        <div class="centerString">
          <h4>HOURS</h4>
        </div>

        <h4>MINUTES</h4>

        <h4>SECONDS</h4>

        <h4></h4>
      </div>
    </div>
  </div>
</template>

<style scoped>
.background {
  background: linear-gradient(180deg, #292e49, #232323);
  height: 100vh;
  display: flex;
  justify-content: center;
  flex-direction: column;
  padding-left: 40px;
  padding-right: 40px;
}

.globalContainer {
  position: relative;
}

.titleString {
  position: relative;
  z-index: 1;
}

.bat1 {
  position: absolute;
  bottom: -100px;
  right: -100px;
  width: 211.7px;
  transform: rotate(30deg);
  z-index: 0;
  height: 118.09;
}

.bat2 {
  position: absolute;
  width: 211.7px;
  transform: rotate(-30deg);
  z-index: 0;
  top: -40px;
  left: 160px;
  height: 118.09;
}

.titles {
  position: relative;
}

.containerDigit {
  display: flex;
  position: relative;
  width: 203px;
}

body {
  font-family: system-ui;
  background: #f06d06;
  color: white;
  text-align: center;
}

.containerSecond {
  display: flex;
  position: relative;
  justify-content: space-between;
  width: 100%;
  padding-left: 45px;
}

.containerButton {
  display: grid;
  position: relative;
  gap: 20px;
  justify-content: center;
  align-items: center;
}

.second {
  position: absolute;
  right: 0;
  top: -85px;
  opacity: 0.3;
  background: -webkit-linear-gradient(#eee, #333);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.third {
  background: -webkit-linear-gradient(#eee, #333);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  position: absolute;
  right: 0;
  bottom: -50px;
  opacity: 0.3;
  z-index: 2;
}

.el-button {
  background-color: #ffffff;
  color: #000000;
  font-weight: 600;
  border-color: #ffffff;
  margin-right: 30px !important;
}

.el-button:hover {
  background-color: #536976;
  border-color: #536976;
}

.container {
  display: flex;
  justify-content: space-between;
}

a {
  text-decoration: none;
}

h1 {
  font-size: 10rem;
  font-weight: 500;
  color: #fff;

  margin: 0;
}

h3 {
  font-size: 2rem;
  font-weight: 400;
  color: #fff;

  margin: 0;
}

h4 {
  font-size: 1.5rem !important;
  font-weight: 300 !important;
  color: #fff !important;
  width: 260px !important;
  margin: 0 !important;
  text-align: start !important;
}

h2 {
  font-size: 3rem;
  font-weight: 700;
  color: #fff;
  margin: 0;
}

@media screen and (min-width: 900px) {
  .el-button {
    padding: 20px 30px !important;
  }
}


@media screen and (max-width: 900px) {
  .h1 {
    display: none;
  }

  h2 {
    font-size: 2.5rem;
  }

  .containerDigit {
    display: none;
  }

  .containerSecond {
    display: none;
  }

  .firstDigits {
    display: none;
  }

  .containerButton {
    width: 100vw;
  }

  .titleString {
    margin-bottom: 30px;
    display: flex;
    justify-content: center;
  }

  a {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 30px;
  }


  .bat2 {
    width: 150px;
  }
}
</style>
