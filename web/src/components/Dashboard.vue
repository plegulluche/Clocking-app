

<template>
  <div class="background">
    <div class="parent">
      <div class="div1">
        <div class="block1">
          <h2>Logs</h2>
          <div class="buttonctn">
            <p>7 AM</p>
          </div>
          <div class="buttonctn">
            <p>1 PM</p>
          </div>
          <div class="buttonctn">
            <p>3 PM</p>
          </div>
        </div>
      </div>

      <div class="div2">
        <div class="block2">
          <div class="accountManagerCtn">

            <div class="buttonctn" @click="logOut">
              <div class="outTxt">Log-out</div>
            </div>


            <div class="buttonctn" @click="deleteAccount">
              <div class="deleteBtn">Delete this account</div>
            </div>

            <div v-if="userStore.currentUser.role == 'general_manager'">
              <div class="buttonctn" @click="adminPanel">
                <div class="deleteBtn">Back to users list</div>
              </div>

            </div>
          </div>
        </div>
      </div>

      <div class="div3">
        <div class="block3">
          <div class="modified" @click="modVisible = true">
            <svg width="20" height="20" viewBox="0 0 1200 1200">
              <path fill="currentColor"
                d="M1169.166 190.752L1011.645 33.23C968.21-10.204 894.716-7.362 847.613 39.858c-47.104 47.103-50.181 120.715-6.628 164.148l157.521 157.522c43.435 43.434 116.928 40.594 164.149-6.627c47.105-47.22 50.064-120.596 6.511-164.149zM164.978 722.374l315.044 315.044l511.976-511.857l-315.044-315.044l-511.976 511.857zM0 1197.544l415.522-83.199L83.199 782.021L0 1197.544z" />
            </svg>
          </div>
          <div class="parent2">
            <div class="avatarctn">

              <div class="circleAvatar">
                <img src="../assets/images/Batman-Logo-white.png" alt="avatar" class="avatar">
              </div>
            </div>
            <div class="infoctn">
              <div v-if="userStore.selectedUser">

                <h5 class="name">{{ userStore.selectedUser.username }}</h5>
                <h5 class="email">{{ userStore.selectedUser.email }}</h5>
                <h5 class="globalClock">60% global clock</h5>
              </div>
              <div v-else>
                <h5 class="name">{{ userStore.currentUser.username }}</h5>
                <h5 class="email">{{ userStore.currentUser.email }}</h5>
                <h5 class="globalClock">60% global clock</h5>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="div4">
        <div class="block4">
          <div class="parent4">
            <div class="todayLeft">
              <div class="dataLeftCtn">
                <div class="dataCtn">
                  <div class="fillData">
                    <div class="dataTxt">
                      50%
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="todayRight">
              <div class="todayCtn">
                <!-- <div >
                  <span class="clockIn">Clock in at <span class="clockInTime"></span> <span
                      class="clockInTime">AM</span></span>
                </div> -->
                <div v-if="!userClock.currentClock && userStore.currentUser.role == 'employee'">
                  <div class="buttonctn" @click="createClockIn">
                    <div class="outTxt">Clock-in</div>
                  </div>
                </div>
                <div v-if="userClock.currentClock">
                  <div class="buttonctn">
                    <div class="outTxt">{{ moment(userClock.currentClock).format("ddd, hA") }}</div>
                  </div>
                </div>
                <div v-if="userClock.currentClock">
                  <div class="buttonctn" @click="createClockOut">
                    <div class="outTxt">Clock-out</div>
                  </div>
                </div>
              </div>
            </div>
          </div>

        </div>
      </div>

      <div class="div5">
        <div class="block5">
          <Charts />
        </div>
      </div>
    </div>
    <el-dialog v-model="modVisible" title="Modify user">
      <el-form :model="modUser">
        <el-form-item label="Fill the new Name" :label-width="formLabelWidth">
          <el-input v-model="modUser.name" autocomplete="off" />
        </el-form-item>
        <el-form-item label="Fill the new Email" :label-width="formLabelWidth">
          <el-input type="email" v-model="modUser.email" autocomplete="off" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="modVisible = false">Cancel</el-button>
          <div v-if="selectedUser">

            <el-button type="primary" plain @click="modForm(userStore.selectedUser.id)"> Confirm
            </el-button>
          </div>
          <div v-else>
            <el-button type="primary" plain @click="modForm('')"> Confirm
            </el-button>
          </div>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { useUsers } from "../stores/Users";
import { useClocks } from "../stores/Clock";
import { ref, reactive } from "vue";
import Charts from "./Charts.vue";
import router from "../router";
import moment from "moment";
// const today = new Date();
// const lastWeek = new Date(today.getTime() - 7 * 24 * 60 * 60 * 1000);
// console.log(lastWeek);
const modVisible = ref(false)
const modUser = reactive({
  name: "",
  email: "",
});
const modForm = (user) => {
  modVisible.value = false;
  userStore.updateUser(user, modUser.name, modUser.email)
};
const formLabelWidth = "140px";
const userStore = useUsers();
const userClock = useClocks();
userStore.getCurrentUser();
const currentUser = userStore.currentUser;
console.log("selectedUser: ", userStore.selectedUser);
console.log("currentUser: ", userStore.currentUser);
const logOut = () => {
  userStore.logOut();
  router.push("/");
};
const adminPanel = () => {
  router.push("/admin");
};
const deleteAccount = () => {
  const selectedUser = userStore.selectedUser;
  if (selectedUser) {
    userStore.deleteUser(userStore.selectedUser.id);
    router.push("/admin");
  } else {
    userStore.deleteUser('');
    router.push("/");
  }
};
const createClockIn = () => {
  const now = moment().format()
  userClock.createClock(true, now, userStore.currentUser.id);
  userClock.currentClock = now;
  console.log(userClock.currentClock);
}
const createClockOut = () => {
  const now = moment().format()
  userClock.createClock(false, now, userStore.currentUser.id);
  userClock.createWorkingTime();
  userClock.currentClock = false;

}



</script >
<style scoped lang="scss">
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

.accountManagerCtn {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  margin-top: 40px;
  padding: 20px;
}

.parent {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  grid-template-rows: repeat(5, 1fr);
  grid-column-gap: 0px;
  grid-row-gap: 0px;
}

.parent {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  grid-template-rows: repeat(5, 1fr);
  grid-column-gap: 0px;
  grid-row-gap: 0px;
}

.block1 {
  background: linear-gradient(201.03deg, #292E49 13.88%, #536976 159.01%);
  border-radius: 30px;
  height: 85%;
  width: 85%;
  box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
  display: flex;
  align-items: center;
  flex-direction: column;
}

.div1 {
  grid-area: 1 / 1 / 4 / 2;
  display: flex;
  justify-content: center;
  align-items: center;
}

.deleteBtn {
  color: #292e49;
  font-size: 14px;
  font-weight: 700;
  display: flex;
  justify-content: center;
  align-items: center;
  width: max-content;
}

.block2 {
  background: linear-gradient(228.97deg, #51638D 9.81%, #292E49 86.35%);
  border-radius: 30px;
  height: 85%;
  width: 85%;
  box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
}

.div2 {
  grid-area: 4 / 1 / 6 / 2;
  height: 40vh;
  display: flex;
  justify-content: center;
  align-items: center;
}

.modified {
  padding: 5px;
  padding-left: 6px;
  padding-right: 6px;
  border-radius: 50px;
  background-color: #fff;
  position: absolute;
  right: -6px;
  top: -6px;
  transition: all .3s ease-out;

  &:hover {
    cursor: pointer;
    background-color: #51638D;
    color: #fff;
    transform: scale(1.2);
    transition: all 0.3s ease-in-out;
  }
}

.block3 {
  background: linear-gradient(74.08deg, #536976 -17.29%, #292E49 142.97%);
  border-radius: 30px;
  height: 85%;
  width: 85%;
  box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
  position: relative;
}

.div3 {
  grid-area: 1 / 2 / 3 / 4;
  display: flex;
  justify-content: center;
  align-items: center;
}

.block4 {
  background: #536976;
  ;
  border-radius: 30px;
  height: 85%;
  width: 85%;
  box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
}

.avatar {
  width: 100px;
}

.div4 {
  grid-area: 1 / 4 / 3 / 6;
  display: flex;
  justify-content: center;
  align-items: center;
}

.block5 {
  background: linear-gradient(261.61deg, #536976 -2.24%, #292E49 88.95%);
  border-radius: 30px;
  height: 85%;
  width: 85%;
  box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
  padding: 20px;
}

.div5 {
  grid-area: 3 / 2 / 6 / 6;
  display: flex;
  justify-content: center;
  align-items: center;
}

.buttonctn {
  background: #D9D9D9;
  box-shadow: 0px 4px 4px rgb(0 0 0 / 25%);
  border-radius: 30px;
  padding-bottom: 10px;
  padding-top: 10px;
  padding-left: 20px;
  padding-right: 20px;
  min-width: 80px;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 10px;
  margin-bottom: 10px;
  cursor: pointer;

  &:hover {
    background: #c4c4c4;
  }
}

.parent2 {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  grid-template-rows: repeat(4, 1fr);
  grid-column-gap: 0px;
  grid-row-gap: 0px;
  height: 100%
}

.avatarctn {
  grid-area: 1 / 1 / 5 / 3;
  display: flex;
  justify-content: center;
  align-items: center;
}

.infoctn {
  grid-area: 1 / 3 / 5 / 7;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.circleAvatar {
  height: 100px;
  width: 100px;
  background: #292E49;
  border: 3px solid #FFFFFF;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.name {
  color: #FFFFFF;
}

.email {
  color: #A6A6A6;
}

.globalClock {
  color: #292E49
}

.parent3 {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  grid-template-rows: repeat(5, 1fr);
  grid-column-gap: 0px;
  grid-row-gap: 0px;
  height: 100%
}

.leftBlock {
  grid-area: 1 / 5 / 6 / 7;
}

.rightBlock {
  grid-area: 1 / 1 / 6 / 5;
}

.shadowctn {
  background: linear-gradient(88.26deg, rgba(217, 217, 217, 0.5) -9.78%, rgba(217, 217, 217, 0) 97.55%);
  mix-blend-mode: normal;
  border-radius: 0px 30px 30px 0px;
  height: 100%;
}

.parent4 {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  grid-template-rows: repeat(5, 1fr);
  grid-column-gap: 0px;
  grid-row-gap: 0px;
  height: 100%;
}

.todayLeft {
  grid-area: 1 / 1 / 6 / 3;
}

.todayRight {
  grid-area: 1 / 3 / 6 / 7;
}

.clockIn {
  color: #FFFFFF;
  font-size: 20px;
  font-weight: 700;
}

.clockInTime {
  margin-left: 10px;
  color: #232323;
  font-weight: 700;
  font-size: 20px;
}

.todayCtn {
  display: grid;
  align-items: center;
  height: 100%;
  justify-content: center;
}

.dataCtn {
  height: 150px;
  width: 50px;
  border-radius: 30px;
  background: #FFFFFF;
  display: flex;
  justify-content: end;
  align-items: flex-end;
}

.dataLeftCtn {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100%;
}

.fillData {
  height: 50%;
  width: 100%;
  border-radius: 50px;
  background: #232323;
  display: flex;
  justify-content: center;
  align-items: center;
  box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
}

.rightCtnData {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  height: 100%;
}

.centerData {
  display: flex;
  height: 100%;
  width: 100%;
  justify-content: center;
  align-items: center;
}

.dataTxt {
  color: #FFFFFF;
  font-size: 14px;
  font-weight: 700;
}

.outTxt {
  color: #232323;
  font-size: 14px;
  font-weight: 700;
  display: flex;
  justify-content: center;
  align-items: center;
  width: max-content;
}

.dataStringCenter {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.lastWtxt {
  margin-top: 10px;
  color: #232323;
  font-size: 14px;
  font-weight: 700;
}

.rightCtnData2 {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  height: 70%;
  margin-left: 20px;
  justify-content: end;
  align-items: end;
}

.splitHalf {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100%;
}

.titleCtn {
  display: flex;
  margin-left: 10%;
  margin-top: 2%;
  align-items: center;
}

.titleWeek {
  color: #ffffff;
  font-weight: 700;
}

p {
  margin: 0px;
  font-weight: 700;
}

h2 {
  color: #FFFFFF;
}

h5 {
  margin: 10px;
}
</style>