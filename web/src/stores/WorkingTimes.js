import { defineStore } from "pinia";
import axios from "axios";

export const useWorkingtimes = defineStore("workingtimes", {
  state: () => ({
    workingtimes: [],
    workingtime: {},
  }),
  getters: {},
  actions: {
   
    async getworkingtimes() {
      const res = await axios.get(`http://176.31.162.57:4000/api/workingtimes`);
    },
  },
});

