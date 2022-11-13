<template>
    <div class="background">
        <img src="../assets/images/Batman-Logo.png" alt="batmanLogo" class="bat1" />
        <img src="../assets/images/Batman-Logo.png" alt="batmanLogo" class="bat2" />
        <img src="../assets/images/Batman-Logo.png" alt="batmanLogo" class="bat3" />

        <div class="title">
            <h1>Users</h1>
        </div>
        <div class="card">
            <div class="user" v-for="user in userStore.users" :key="user.id">
                <div class="userCtn">
                    <div class="div1" @click="routeUser(user)">
                        <p>{{ user.username }}</p>
                    </div>
                    <div class="div2">
                        <p>{{ user.email }}</p>
                    </div>
                    <div class="div3" @click="modVisible = true">
                        <svg width="32" height="32" viewBox="0 0 1200 1200">
                            <path fill="currentColor"
                                d="M1169.166 190.752L1011.645 33.23C968.21-10.204 894.716-7.362 847.613 39.858c-47.104 47.103-50.181 120.715-6.628 164.148l157.521 157.522c43.435 43.434 116.928 40.594 164.149-6.627c47.105-47.22 50.064-120.596 6.511-164.149zM164.978 722.374l315.044 315.044l511.976-511.857l-315.044-315.044l-511.976 511.857zM0 1197.544l415.522-83.199L83.199 782.021L0 1197.544z" />
                        </svg>
                    </div>
                    <div class="div4" @click="deleteUser(user.id)">
                        <svg width="32" height="32" viewBox="0 0 512 512">
                            <rect width="448" height="80" x="32" y="48" fill="currentColor" rx="32" ry="32" />
                            <path fill="currentColor"
                                d="M74.45 160a8 8 0 0 0-8 8.83l26.31 252.56a1.5 1.5 0 0 0 0 .22A48 48 0 0 0 140.45 464h231.09a48 48 0 0 0 47.67-42.39v-.21l26.27-252.57a8 8 0 0 0-8-8.83Zm248.86 180.69a16 16 0 1 1-22.63 22.62L256 318.63l-44.69 44.68a16 16 0 0 1-22.63-22.62L233.37 296l-44.69-44.69a16 16 0 0 1 22.63-22.62L256 273.37l44.68-44.68a16 16 0 0 1 22.63 22.62L278.62 296Z" />
                        </svg>
                    </div>
                </div>
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
    </div>
</template>

<script setup >
import { useUsers } from "../stores/Users";
import { ref, reactive } from "vue";
import router from "../router";
const userStore = useUsers();
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

function deleteUser(userId) {
    userStore.deleteUser(userId);
}

function routeUser(user) {
    userStore.setSelectedUser(user);
    router.push("/dashboard");
}
</script>
<style scoped lang="scss">
.background {
    background: linear-gradient(180deg, #292e49, #232323);
    height: 100vh;
    width: 100%;
    display: flex;
    position: relative;
    justify-content: center;
    flex-direction: column;
    padding-left: 40px;
    padding-right: 40px;
}

.title {
    display: flex;
    justify-content: center;
    align-items: center;
    color: #fff;
    position: relative;
    z-index: 2;

}

.bat1 {
    position: absolute;
    width: 211.7px;
    transform: rotate(-15deg);
    z-index: 0;
    right: 50%;
    top: 10%;
}

.bat2 {
    position: absolute;
    width: 211.7px;
    transform: rotate(-48deg);
    z-index: 0;
    left: 10%;
    top: 50%;
}

.bat3 {
    position: absolute;
    width: 211.7px;
    transform: rotate(44deg);
    z-index: 0;
    right: 24%;
    bottom: 14%;
}

.userCtn {
    border-radius: 50px;
    padding-right: 20px;
    padding-left: 30px;
    padding-top: 10px;
    padding-bottom: 10px;
    background: linear-gradient(228.97deg, #51638D 9.81%, #292E49 86.35%);
    box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
    display: grid;
    grid-template-columns: repeat(8, 1fr);
    grid-template-rows: 1fr;
    grid-column-gap: 0px;
    grid-row-gap: 0px;
    margin-bottom: 20px;

    transition: all .3s ease-out;

    &:hover {
        transform: scale(1.02);
        transition: all 0.3s ease-in-out;
    }
}

.div1 {
    grid-area: 1 / 1 / 2 / 3;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;

    &hover {
        background: linear-gradient(228.97deg, #51638D 9.81%, #292E49 86.35%);
        box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
        border-radius: 50px;
    }
}

.div2 {
    grid-area: 1 / 3 / 2 / 7;
    display: flex;
    align-items: center;
    justify-content: center;
}

.div3 {
    grid-area: 1 / 7 / 2 / 8;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;

    &:hover {
        background: linear-gradient(228.97deg, #51638D 9.81%, #292E49 86.35%);
        box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
        border-radius: 50px;
    }

}

.div4 {
    grid-area: 1 / 8 / 2 / 9;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;

    &:hover {
        background: linear-gradient(228.97deg, #51638D 9.81%, #292E49 86.35%);
        box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
        border-radius: 50px;
    }
}

.user {
    color: #fff;
    font-weight: 600;

}

.card {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.6);
    padding: 40px;

    max-width: 100%;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    height: 60vh;
    overflow-y: scroll;
    width: 50vw;
}

@media screen and (max-width: 900px) {
    .userCtn {
        display: block;
    }

    .div3 {
        margin-top: 20px;
    }

    .div4 {
        margin-top: 20px;
    }
}
</style>