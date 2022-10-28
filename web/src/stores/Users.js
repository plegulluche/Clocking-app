import { defineStore } from "pinia";
import axios from "axios";

export const useUsers = defineStore("users", {
  state: () => ({
    users: [],
    user: {},
  }),
  getters: {},
  actions: {
    async getUsers() {
      const res = await axios.get("http://172.31.38.29:4000/api/users");
      this.users = res.data.data;
    },
    async getOneUser(userId) {
      const res = await axios.get(`http://172.31.38.29:4000/api/users/${userId}`);
      this.user = res.data.data;
    },
    async deleteUser(userId) {
      const res = await axios.delete(
        `http://172.31.38.29:4000/api/users/${userId}`
      );
      if (res) {
        const newUsers = await axios.get("http://172.31.38.29:4000/api/users");
        this.users = newUsers.data.data;
      }
    },
    async addUser(username, email) {
      const res = await axios.post(
        "http://172.31.38.29:4000/api/users",
        { user: { username: username, email: email } },
        { headers: { "Content-Type": "application/json" } }
      );
      if (res) {
        const newUsers = await axios.get("http://172.31.38.29:4000/api/users");
        this.users = newUsers.data.data;
      }
    },
    async updateUser(userId, username, email) {
      const res = await axios.patch(
        `http://172.31.38.29:4000/api/users/${userId}`,
        { user: { username: username, email: email } },
        { headers: { "Content-Type": "application/json" } }
      );
      if (res) {
        const newUsers = await axios.get("http://172.31.38.29:4000/api/users");
        this.users = newUsers.data.data;
      }
    },
  },
});
