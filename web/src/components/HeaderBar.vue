<template>
  <div class="stick" aria-label="A complete example of page header">
    <el-page-header @back="onBack">
      <template #content>
        <div class="flex items-center">
          <User />
          <ClockManager />
          <WorkingTime />
        </div>
      </template>
      <template #extra>
        <div class="flex items-center"></div>
      </template>

      <el-descriptions :column="3" size="small" class="mt-4"> </el-descriptions>
    </el-page-header>
  </div>
</template>

<style>
.stick {
  position: sticky;
  top: 0;
  z-index: 1;
  margin-bottom: 10px;
}
</style>
<script setup lang="ts">
import ClockManager from "./ClockManager.vue";
import User from "./User.vue";
import WorkingTime from "./WorkingTime.vue";
import { ElNotification as notify } from "element-plus";

const onBack = () => {
  notify("Back");
};
</script>
