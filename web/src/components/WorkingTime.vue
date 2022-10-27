<template>
  <el-dropdown>
    <span class="el-dropdown-link">
      Working Time<el-icon class="el-icon--right">
        <arrow-down />
      </el-icon>
    </span>
    <template #dropdown>
      <el-dropdown-menu>
        <el-dropdown-item text @click="createVisible = true"
          >Create Working Time
        </el-dropdown-item>
        <el-dropdown-item text @click="modVisible = true"
          >Update Working Time
        </el-dropdown-item>
        <el-dropdown-item text @click="deleteVisible = true"
          >Delete Working Time
        </el-dropdown-item>
      </el-dropdown-menu>
    </template>
  </el-dropdown>
  <el-dialog v-model="createVisible" title="Create Working Time">
    <el-form :model="newworktime">
      <el-form-item label="Select the start Time" :label-width="formLabelWidth">
        <el-date-picker
          v-model="newworktime.starttime"
          type="datetime"
          placeholder="Pick a Date"
          format="YYYY-MM-DD HH:mm:ss"
        />
      </el-form-item>
      <el-form-item label="Select the end Time" :label-width="formLabelWidth">
        <el-date-picker
          v-model="newworktime.endtime"
          type="datetime"
          placeholder="Pick a Date"
          format="YYYY-MM-DD HH:mm:ss"
        />
      </el-form-item>
      <el-form-item label="Fill the User ID" :label-width="formLabelWidth">
        <el-input v-model="newworktime.userid" autocomplete="off" />
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="createVisible = false">Cancel</el-button>
        <el-button type="primary" @click="createForm"> Confirm </el-button>
      </span>
    </template>
  </el-dialog>
  <el-dialog v-model="modVisible" title="Update Working Time">
    <el-form :model="modworktime">
      <el-form-item label="Select the start Time" :label-width="formLabelWidth">
        <el-date-picker
          v-model="modworktime.starttime"
          type="datetime"
          placeholder="Pick a Date"
          format="YYYY-MM-DD HH:mm:ss"
        />
      </el-form-item>
      <el-form-item label="Select the end Time" :label-width="formLabelWidth">
        <el-date-picker
          v-model="modworktime.endtime"
          type="datetime"
          placeholder="Pick a Date"
          format="YYYY-MM-DD HH:mm:ss"
        />
      </el-form-item>
      <el-form-item label="Fill the User ID" :label-width="formLabelWidth">
        <el-input v-model="modworktime.userid" autocomplete="off" />
      </el-form-item>
      <el-form-item label="Fill the WorkTime ID" :label-width="formLabelWidth">
        <el-input v-model="modworktime.worktimeid" autocomplete="off" />
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="modVisible = false">Cancel</el-button>
        <el-button type="primary" @click="modForm"> Confirm </el-button>
      </span>
    </template>
  </el-dialog>
  <el-dialog v-model="deleteVisible" title="Delete Working Time">
    <el-form :model="deleteworktime">
      <el-form-item
        label="Fill the ID of the User"
        :label-width="formLabelWidth"
      >
        <el-input v-model="deleteworktime.userid" autocomplete="off" />
      </el-form-item>
      <el-form-item label="Fill the WorkTime ID" :label-width="formLabelWidth">
        <el-input v-model="deleteworktime.worktimeid" autocomplete="off" />
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="deleteVisible = false">Cancel</el-button>
        <el-button type="primary" @click="deleteForm"> Confirm </el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script lang="ts" setup>
import { ElMessage } from "element-plus";
import { ArrowDown } from "@element-plus/icons-vue";
import { reactive, ref } from "vue";

const createVisible = ref(false);
const modVisible = ref(false);
const deleteVisible = ref(false);

const formLabelWidth = "140px";

const newworktime = reactive({
  starttime: "",
  endtime: "",
  userid: "",
});
const modworktime = reactive({
  starttime: "",
  endtime: "",
  userid: "",
  worktimeid: "",
});
const deleteworktime = reactive({
  worktimeid: "",
  userid: "",
});

const createForm = () => {
  createVisible.value = false;
  ElMessage({
    type: "info",
    message: `${newworktime.starttime} ${newworktime.endtime} ${newworktime.userid}`,
  });
  newworktime.starttime = "";
  newworktime.endtime = "";
  newworktime.userid = "";
};
const modForm = () => {
  modVisible.value = false;
  ElMessage({
    type: "info",
    message: `${modworktime.starttime} ${modworktime.endtime} ${modworktime.userid} ${modworktime.worktimeid}`,
  });
  modworktime.starttime = "";
  modworktime.endtime = "";
  modworktime.worktimeid = "";
  modworktime.userid = "";
};
const deleteForm = () => {
  deleteVisible.value = false;
  ElMessage({
    type: "info",
    message: `${deleteworktime.worktimeid} ${deleteworktime.userid}`,
  });
};
</script>

<style scoped>
.el-dropdown-link {
  cursor: pointer;
  border: 1px solid;
  border-radius: 10px;
  color: black;
  width: 10rem;
  height: 2rem;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 10px;
  margin-left: 10px;
}

.el-dropdown__popper .el-dropdown-menu {
  width: 10rem;
}

.el-button--text {
  margin-right: 15px;
}

.el-select {
  width: 300px;
}

.el-input {
  width: 300px;
}

.dialog-footer button:first-child {
  margin-right: 10px;
}
</style>
