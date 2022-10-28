<template>
  <el-dropdown>
    <span class="el-dropdown-link">
      User<el-icon class="el-icon--right">
        <arrow-down />
      </el-icon>
    </span>
    <template #dropdown>
      <el-dropdown-menu>
        <el-dropdown-item text @click="createVisible = true"
          >Create User
        </el-dropdown-item>
        <el-dropdown-item text @click="modVisible = true"
          >Update User
        </el-dropdown-item>
        <el-dropdown-item text @click="deleteVisible = true"
          >Delete User
        </el-dropdown-item>
      </el-dropdown-menu>
    </template>
  </el-dropdown>
  <el-dialog v-model="createVisible" title="Create user">
    <el-form :model="newuser">
      <el-form-item label="Fill your Name" :label-width="formLabelWidth">
        <el-input v-model="newuser.name" autocomplete="off" />
      </el-form-item>
      <el-form-item label="Fill you Email Adress" :label-width="formLabelWidth">
        <el-input v-model="newuser.email" autocomplete="off" />
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="createVisible = false">Cancel</el-button>
        <el-button type="primary" @click="createForm"> Confirm </el-button>
      </span>
    </template>
  </el-dialog>
  <el-dialog v-model="modVisible" title="Update user">
    <el-form :model="moduser">
      <el-form-item
        label="Fill the ID of the User"
        :label-width="formLabelWidth"
      >
        <el-input v-model="moduser.id" autocomplete="off" />
      </el-form-item>
      <el-form-item label="Fill your Name" :label-width="formLabelWidth">
        <el-input v-model="moduser.name" autocomplete="off" />
      </el-form-item>
      <el-form-item label="Fill you Email Adress" :label-width="formLabelWidth">
        <el-input v-model="moduser.email" autocomplete="off" />
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="modVisible = false">Cancel</el-button>
        <el-button type="primary" @click="modForm"> Confirm </el-button>
      </span>
    </template>
  </el-dialog>
  <el-dialog v-model="deleteVisible" title="Delete user">
    <el-form :model="deleteeuser">
      <el-form-item
        label="Fill the ID of the User"
        :label-width="formLabelWidth"
      >
        <el-input v-model="deleteeuser.id" autocomplete="off" />
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
import {
  ElButton,
  ElDialog,
  ElDropdown,
  ElDropdownItem,
  ElDropdownMenu,
  ElForm,
  ElFormItem,
  ElIcon,
  ElInput,
  ElMessage,
} from "element-plus";
import { ArrowDown } from "@element-plus/icons-vue";
import { reactive, ref } from "vue";
import axios from "axios";

const createVisible = ref(false);
const modVisible = ref(false);
const deleteVisible = ref(false);

const formLabelWidth = "140px";

const newuser = reactive({
  name: "",
  email: "",
});
const moduser = reactive({
  id: "",
  name: "",
  email: "",
});
const deleteeuser = reactive({
  id: "",
});

const createForm = () => {
  if (newuser.name === "" || newuser.email === "") {
    ElMessage({
      message: "Please fill all the fields",
      type: "error",
    });
  } else {
    axios({
      method: "post",
      url: "http://172.31.38.29:4000/api/users",
      data: {
        user: {
          username: newuser.name,
          email: newuser.email,
        },
      },
    });
    ElMessage({
      message: `${newuser.name} created`,
      type: "success",
    });
    createVisible.value = false;
  }
};
const modForm = () => {
  modVisible.value = false;
  if (moduser.id === "" || moduser.name === "" || moduser.email === "") {
    ElMessage({
      message: "Please fill all the fields",
      type: "error",
    });
  } else {
    axios({
      method: "put",
      url: `http://172.31.38.29:4000/api/users/${moduser.id}`,
      data: {
        user: {
          username: moduser.name,
          email: moduser.email,
        },
      },
    });
    ElMessage({
      message: `${moduser.name} updated`,
      type: "success",
    });
    modVisible.value = false;
  }
};
const deleteForm = () => {
  if (deleteeuser.id === "") {
    ElMessage({
      message: "Please fill all the fields",
      type: "error",
    });
  } else {
    axios({
      method: "delete",
      url: `http://172.31.38.29:4000/api/users/${deleteeuser.id}`,
    });
    ElMessage({
      message: `${deleteeuser.id} deleted`,
      type: "success",
    });
    deleteVisible.value = false;
  }
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
