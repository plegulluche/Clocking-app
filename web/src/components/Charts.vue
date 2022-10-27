<script setup>
import UserList from "./UserList.vue";
</script>
<template>
  <el-row class="row-bg" justify="space-evenly">
    <el-col :span="6">
      <el-card class="box-card">
        <div class="title">
          Titre
          <el-divider />
        </div>
        <div class="content">content</div></el-card
      ></el-col
    >
    <el-col :span="6">
      <el-card class="box-card">
        <div class="title">
          Titre
          <el-divider />
        </div>
        <div class="content">content</div></el-card
      ></el-col
    >
    <el-col :span="6">
      <el-card class="box-card">
        <div class="title">
          Titre
          <el-divider />
        </div>
        <div class="content">content</div></el-card
      ></el-col
    >
  </el-row>
  <UserList />
</template>
<style scoped>
.text {
  font-size: 14px;
}

.content {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100px;
}

.item {
  padding: 18px 0;
}
</style>
