<script lang="ts" setup>
import { useUsers } from "../stores/Users";
import { ref, onMounted } from "vue";
import axios from "axios";
const userStore = useUsers();
let allUsers = ref([]);
userStore.getUsers();
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
        <div v-for="user in userStore.users" :key="user.id">
          <el-row :gutter="20">
            <el-col :span="14">
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
            <el-col :span="3">
              <el-button
                type="danger"
                plain
                @click="userStore.deleteUser(user.id)"
              >
                <el-icon name="el-icon-delete"></el-icon>
              </el-button>
            </el-col>
            <el-col :span="3">
              <el-button
                type="primary"
                plain
                @click="userStore.updateUser(user.id)"
              ></el-button>
            </el-col>
          </el-row>
        </div></div
    ></el-card>
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
