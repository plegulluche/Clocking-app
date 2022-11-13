<template>
  <div class="background">
    <img class="batBack1" src="../assets/images/Batman-Logo.png" alt="avatar" />
    <img class="batBack2" src="../assets/images/Batman-Logo.png" alt="avatar" />
    <img class="batBack3" src="../assets/images/Batman-Logo.png" alt="avatar" />
    <div class="card">
      <div class="containerAvatar">
        <div class="roundAvatar">
          <img class="imgAvatar" src="../assets/images/Batman-Logo-white.png" alt="avatar" />
        </div>
        <h5>Time manager</h5>
        <h4>Log in to Time Manager</h4>
        <p class="subtitle">Enter your email and password below</p>
        <el-form ref="ruleFormRef" :model="ruleForm" status-icon :rules="rules" class="demo-ruleForm">
          <div class="inputLabel">
            <div class="labelForm">
              <p>Email</p>
            </div>
            <el-form-item prop="email">
              <el-input v-model="ruleForm.email" type="email" autocomplete="off" />
            </el-form-item>
          </div>
          <div class="inputLabel">
            <div class="labelForm">
              <p>Password</p>
            </div>
            <el-form-item prop="pass">
              <el-input v-model="ruleForm.pass" type="password" autocomplete="off" />
            </el-form-item>
          </div>

          <el-form-item>
            <el-button class="submitButton" type="primary" @click="submitForm(ruleFormRef)">Log in</el-button>
            <el-button class="resetButton" @click="resetForm(ruleFormRef)">Reset</el-button>
          </el-form-item>
        </el-form>
      </div>
      <div class="containerSignup">
        <span class="subtitle">don't have an account ?</span>
        <RouterLink to="/Register" class="button">
          <span class="signup">Sign up</span>
        </RouterLink>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { reactive, ref } from "vue";
import type { FormInstance } from "element-plus";
import { useUsers } from "../stores/Users";
const userStore = useUsers();
const ruleFormRef = ref<FormInstance>();



const ruleForm = reactive({
  pass: "",
  email: "",
});

const infos = localStorage.getItem("LoginInfos");
if (infos) {
  const infosParsed = JSON.parse(infos);
  ruleForm.email = infosParsed.data.email;
}

const rules = reactive({
  pass: [{ trigger: "blur" }],
  email: [
    {
      type: "email",
      message: "Please input correct email address",
      trigger: ["blur", "change"],
    },
  ],
});

const submitForm = (formEl: FormInstance | undefined) => {
  if (!formEl) return;
  formEl.validate((valid) => {
    if (valid) {
      userStore.login(ruleForm.email, ruleForm.pass);

    } else {
      return false;
    }
  });
};

const resetForm = (formEl: FormInstance | undefined) => {
  if (!formEl) return;
  formEl.resetFields();
};
</script>

<style scoped>
.background {
  background: linear-gradient(180deg, #292e49, #232323);
  height: 100vh;
  display: flex;
  position: relative;
  justify-content: center;
  flex-direction: column;
  padding-left: 40px;
  padding-right: 40px;
}

.card {
  background: #fff;
  border-radius: 10px;
  padding: 20px;
  position: relative;
  margin: 0 auto;
  z-index: 100;
  max-width: 100vw;

}

@media screen and (min-width: 900px) {
  .card {
    width: 400px;
  }
}

.labelForm {
  display: flex;
  justify-content: start;
  margin: 0px !important;
}

.containerAvatar {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}

.roundAvatar {
  height: 30px;
  width: 30px;
  padding: 6px;
  /* padding-left: 11px; */
  border-radius: 50%;
  background-color: #292e49;
}

.imgAvatar {
  height: 100%;
  width: 100%;
  object-fit: contain;
  border-radius: 50%;
}

a {
  text-decoration: none;
}

h4 {
  color: #232323;
  font-weight: 700;
  font-size: 24px;
  line-height: 30px;
  text-align: center;
  letter-spacing: 0.3px;
  margin: 10px;
}

h5 {
  font-weight: 700;
  line-height: 24px;
  text-align: center;
  letter-spacing: 0.4px;
  color: #a4a6b3;
  opacity: 0.7;
  margin-top: 10px;
  margin-bottom: 20px;
}

p {
  font-weight: 400;
  font-size: 14px;
  line-height: 20px;
  /* identical to box height, or 143% */

  text-align: center;
  letter-spacing: 0.3px;

  /* grayscale / gray */

  color: #9fa2b4;
  margin: 0px;
}

span {
  font-weight: 400;
  font-size: 14px;
  line-height: 20px;
  /* identical to box height, or 143% */

  text-align: center;
  letter-spacing: 0.3px;

  /* grayscale / gray */

  color: #9fa2b4;
  margin: 0px;
}

.el-form-item__content {
  margin: 0px !important;
}

.el-form-item {
  margin-bottom: 0px !important;
}

.subtitle {
  margin-top: 0px;
  margin-bottom: 30px;
}

.inputLabel {
  margin-bottom: 20px;
}

.submitButton {
  margin-top: 20px;
  height: 50px;
  width: 100%;
  background: #292e49;
  border-radius: 10px;
  color: #fff;
  font-weight: 700;
  font-size: 14px;
  line-height: 20px;
  text-align: center;
  letter-spacing: 0.3px;
  border-color: #292e49;
}

.resetButton {
  height: 50px;
  width: 100%;
  background: #fff;
  border-radius: 10px;
  color: #292e49;
  font-weight: 700;
  font-size: 14px;
  line-height: 20px;
  /* identical to box height, or 143% */

  text-align: center;
  letter-spacing: 0.3px;

  /* grayscale / gray */

  color: #9fa2b4;
  border-color: #9fa2b4;
  margin-top: 10px;
}

.resetButton:hover {
  background: #536976;
  color: #fff;
}

.submitButton:hover {
  background: #536976;
  color: #fff;
  border-color: #536976;
}

.el-button+.el-button {
  margin-left: 0px;
}

.batBack1 {
  position: absolute;
  width: 211.7px;
  transform: rotate(30deg);
  z-index: 0;
  right: 13%;
  height: 118.09;
}

.batBack2 {
  position: absolute;
  width: 211.7px;
  transform: rotate(-30deg);
  z-index: 0;
  right: 69%;
  height: 118.09;
}

.batBack3 {
  position: absolute;
  width: 211.7px;
  transform: rotate(-15deg);
  z-index: 0;
  right: 30px;
  top: 0;
  height: 118.09;
}

.el-input {
  height: 45px !important;
}

form {
  width: 85%;
}

.containerSignup {
  display: flex;
  text-align: center;
  justify-content: center;
  margin-top: 20px;
}

.signup {
  color: #292e49;
  font-weight: 700;
  font-size: 14px;
  line-height: 20px;
  /* identical to box height, or 143% */

  letter-spacing: 0.3px;

  /* grayscale / gray */

  margin: 0px;
}
</style>
