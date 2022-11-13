import { defineStore } from "pinia";
import axios from "axios";
import router from "../router";


export const useUsers = defineStore("users", {
  state: () => ({
    users: [],
    user: {},
    currentUser: {},
    selectedUser: false,
  }),
  getters: {},
  actions: {
    async getUsers() {
      const token = localStorage.getItem("token");
      const res = await axios.get("http://176.31.162.57:4000/api/users",
      {
        headers: { "Authorization" : `Bearer ${token}` } }
      );
      this.users = res.data.data;
    },

    async getOneUser(userId) {
      const res = await axios.get(`http://176.31.162.57:4000/api/users/${userId}`);
      this.user = res.data.data;
    },
    async deleteUser(userId) {
      const token = localStorage.getItem("token");
      const res = await axios.delete(
        `http://176.31.162.57:4000/api/users/${userId}`,
        {
          headers: { "Authorization" : `Bearer ${token}` } }
      );
      if (res) {
        this.getUsers();
      }
    },
    async register(username, email, password) {
      const res = await axios.post("http://176.31.162.57:4000/api/auth/register", {
        user: {
          username,
          email,
          password,
          role : "employee",
        }
      }
      );
      if (res) {
        router.push("/login");
        localStorage.setItem("LoginInfos", JSON.stringify(res.data));
      }
    },
    async login(email, password) {
      const res = await axios.post("http://176.31.162.57:4000/api/auth/login", {
        user: {
          email,
          password
        }
      }
      );
      if (res) {
        localStorage.setItem("token", res.data.token);
        localStorage.removeItem("LoginInfos");
        this.selectedUser = false;
        // console.log(res.data);
        if (res.data.role === "admin") {
          router.push("/admin");
        } else {
      router.push("/dashboard");
        }
      }
    },

    async getCurrentUser() {
      const token = localStorage.getItem("token");
      const res = await axios.get("http://176.31.162.57:4000/api/", 
      {
        headers: { "Authorization" : `Bearer ${token}` } }
      );
      if (res) this.currentUser = res.data.data;
      // console.log(this.currentUser);
    },

    async logOut() {
      const token = localStorage.getItem("token");
      const res = await axios.delete("http://176.31.162.57:4000/api/", 
      {
        headers: { "Authorization" : `Bearer ${token}` } }
      );
    },


    async addUser(username, email, password, role) {
      const res = await axios.post(
        "http://176.31.162.57:4000/api/users",
        { user: { username: username, email: email } },
        { headers: { "Content-Type": "application/json" } }
      );
      if (res) {
        const newUsers = await axios.get("http://176.31.162.57:4000/api/users");
        this.users = newUsers.data.data;
      }
    },
    async updateUser(userId, username, email) {
      const token = localStorage.getItem("token");
      const res = await axios.put(
        `http://176.31.162.57:4000/api/users/${userId}`,
        { user: { username: username, email: email } },
        { headers: { "Content-Type": "application/json", "Authorization" : `Bearer ${token}` } }
      );
      if (res) {
        this.getUsers();
      }
    },
    async setSelectedUser(user) {
      this.selectedUser = user;
    },
    async getSelectedUser() {
      return this.selectedUser;
    }
  },
});
