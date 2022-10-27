<script lang="ts" setup>
import { ref, onMounted } from "vue";
import axios from "axios";
let allUsers = ref([]);
onMounted(async () => {
  // const response = await axios.get("http://localhost:4000/api/users");

  // allUsers = response.data.data;
  // console.log(allUsers);
  //get users from the server
  const response = await axios.get("http://localhost:4000/api/users");
  allUsers.value = response.data.data;

  console.log(allUsers.value);
});
</script>

<template>
  <div>
    <h1></h1>

    <el-card class="box-card">
      <div class="title">
        <h2>Sélectionner un utilisateur</h2>
        <el-divider />
      </div>
      <div class="content">
        <div v-for="user in allUsers" :key="user.id">
          <el-row :gutter="20">
            <el-col :span="24">
              <el-button type="info" plain>
                <div class="userid">
                  {{ user.id }}
                </div>
                <div class="userinfos">
                  {{ user.username }}
                </div>
                <div class="userinfos">
                  {{ user.email }}
                </div>
              </el-button>
            </el-col>
          </el-row>
        </div>
      </div></el-card
    >
  </div>
</template>

<style scoped>
.userid {
  font-weight: bold;
  color: #283618;
  position: relative;
  left: -10px;
  font-size: 20px;
  position: relative;
}
.userinfos {
  color: #606c38;
  font-size: 20px;
  position: relative;
  left: -10px;
  margin-left: 10px;
  margin-right: 10px;
}

.el-button {
  padding: 10px !important;
  height: 45px;
  margin: 5px;
  width: 100%;
  text-align: left;
  align-items: center;
  justify-content: center;
}
</style>
