<template>
  <el-dropdown>
    <span class="el-dropdown-link">
      Clock Manager<el-icon class="el-icon--right">
        <arrow-down />
      </el-icon>
    </span>
    <template #dropdown>
      <el-dropdown-menu>
        <el-dropdown-item text @click="createVisible = true"
          >Create Clock Manager
        </el-dropdown-item>
        <el-dropdown-item text @click="modVisible = true"
          >Update Clock Manager
        </el-dropdown-item>
        <el-dropdown-item text @click="deleteVisible = true"
          >Delete Clock Manager
        </el-dropdown-item>
      </el-dropdown-menu>
    </template>
  </el-dropdown>
  <el-dialog v-model="createVisible" title="Create Clock Manager">
    <el-form :model="newclockmanager">
      <el-form-item label="Select the Time" :label-width="formLabelWidth">
        <el-date-picker
          v-model="newclockmanager.time"
          type="datetime"
          placeholder="Pick a Date"
          format="YYYY-MM-DD"
        />
      </el-form-item>
      <el-form-item label="Select the Status" :label-width="formLabelWidth">
        <el-switch v-model="newclockmanager.status" />
      </el-form-item>
      <el-form-item label="Fill the User ID" :label-width="formLabelWidth">
        <el-input v-model="newclockmanager.userid" autocomplete="off" />
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="createVisible = false">Cancel</el-button>
        <el-button type="primary" @click="createForm"> Confirm </el-button>
      </span>
    </template>
  </el-dialog>
  <el-dialog v-model="modVisible" title="Update Clock Manager">
    <el-form :model="modclockmanager">
      <el-form-item label="Select the Time" :label-width="formLabelWidth">
        <el-date-picker
          v-model="modclockmanager.time"
          type="datetime"
          placeholder="Pick a Date"
          format="YYYY-MM-DD"
        />
      </el-form-item>
      <el-form-item label="Select the Status" :label-width="formLabelWidth">
        <el-switch v-model="modclockmanager.status" />
      </el-form-item>
      <el-form-item label="Fill the User ID" :label-width="formLabelWidth">
        <el-input v-model="modclockmanager.userid" autocomplete="off" />
      </el-form-item>
      <el-form-item label="Fill the Clock ID" :label-width="formLabelWidth">
        <el-input v-model="modclockmanager.clockmanagerid" autocomplete="off" />
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="modVisible = false">Cancel</el-button>
        <el-button type="primary" @click="modForm"> Confirm </el-button>
      </span>
    </template>
  </el-dialog>
  <el-dialog v-model="deleteVisible" title="Delete Clock Manager">
    <el-form :model="deleteclockmanager">
      <el-form-item
        label="Fill the ID of the User"
        :label-width="formLabelWidth"
      >
        <el-input v-model="deleteclockmanager.userid" autocomplete="off" />
      </el-form-item>
      <el-form-item label="Fill the Clock ID" :label-width="formLabelWidth">
        <el-input
          v-model="deleteclockmanager.clockmanagerid"
          autocomplete="off"
        />
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

const newclockmanager = reactive({
  status: false,
  time: "",
  userid: "",
});
const modclockmanager = reactive({
  status: false,
  time: "",
  clockmanagerid: "",
  userid: "",
});
const deleteclockmanager = reactive({
  clockmanagerid: "",
  userid: "",
});

const createForm = () => {
  createVisible.value = false;
  ElMessage({
    type: "info",
    message: `${newclockmanager.status} ${newclockmanager.time} ${newclockmanager.userid}`,
  });
  newclockmanager.status = false;
  newclockmanager.time = "";
  newclockmanager.userid = "";
};
const modForm = () => {
  modVisible.value = false;
  ElMessage({
    type: "info",
    message: `${modclockmanager.status} ${modclockmanager.time} ${modclockmanager.userid}`,
  });
  modclockmanager.status = false;
  modclockmanager.time = "";
  modclockmanager.clockmanagerid = "";
  modclockmanager.userid = "";
};
const deleteForm = () => {
  deleteVisible.value = false;
  ElMessage({
    type: "info",
    message: `${deleteclockmanager.clockmanagerid} ${deleteclockmanager.userid}`,
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
