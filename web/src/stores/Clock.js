import { defineStore } from "pinia";
import axios from "axios";
import router from "../router";


export const useClocks = defineStore("clocks", {
  state: () => ({
    currentClock: false,
    start : false,
    end: false,
  }),
  getters: {},
  actions: {
    async createClock(status, time, user_id) {
      const token = localStorage.getItem("token");
      const res = await axios.post("http://176.31.162.57:4000/api/clocks", {
        clock: {
          status,
          time,
          user_id
        }
      },
      {
        headers: { "Authorization" : `Bearer ${token}` } }
      );

    },

    async createWorkingTime() {
      const token = localStorage.getItem("token");
      const res = await axios.get("http://176.31.162.57:4000/api/clocks/last_two", 
      {
        headers: { "Authorization" : `Bearer ${token}` } }
      );
      if (res) {
        this.end = res.data.data[0].time;
        this.start = res.data.data[1].time;
        const resTwo = await axios.post("http://176.31.162.57:4000/api/workingtimes",
        { workingtime: { start: this.start, end: this.end, user_id: "" } },
        { headers: { "Authorization" : `Bearer ${token}` } }
        
        );
        if (resTwo) {
          console.log(resTwo);
        }
      }
    },


  

    
    // async createWorkingTime() {
    //   const token = localStorage.getItem("token");
    //   console.log("tefrhgferj");
    //   const res = await axios.get("http://176.31.162.57:4000/api/clocks/last_two", {
    //   },
    //   {
    //     headers: { "Authorization" : `Bearer ${token}` } }
    //     );
    //   },
  },
});