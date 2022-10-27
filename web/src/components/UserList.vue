<script lang="ts" setup>
import { useUsers } from "../stores/Users";
import { ref, onMounted, reactive } from "vue";
import axios from "axios";
const userStore = useUsers();
let allUsers = ref([]);
userStore.getUsers();
const modVisible = ref(false)
const modUser = reactive({
    name: "",
    email: "",
});
const formLabelWidth = "140px";

const modForm = (user) => {
    modVisible.value = false;
    userStore.updateUser(user, modUser.name, modUser.email)
};

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
                            <el-button type="danger" plain @click="userStore.deleteUser(user.id)">
                                <el-icon name="el-icon-delete"></el-icon>
                            </el-button>
                        </el-col>
                        <el-col :span="3">
                            <el-button type="primary" text @click="modVisible = true"></el-button>
                        </el-col>
                    </el-row>
                    <el-dialog v-model="modVisible" title="Modify user">
                        <el-form :model="modUser">
                            <el-form-item label="Fill the new Name" :label-width="formLabelWidth">
                                <el-input v-model="modUser.name" autocomplete="off" />
                            </el-form-item>
                            <el-form-item label="Fill the new Email" :label-width="formLabelWidth">
                                <el-input v-model="modUser.email" autocomplete="off" />
                            </el-form-item>
                        </el-form>
                        <template #footer>
                            <span class="dialog-footer">
                                <el-button @click="modVisible = false">Cancel</el-button>
                                <el-button type="primary" plain @click="modForm(user.id)"> Confirm
                                </el-button>
                            </span>
                        </template>
                    </el-dialog>
                </div>
            </div>
        </el-card>
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
