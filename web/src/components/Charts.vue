

<script>

import axios from 'axios';
import Chart from 'chart.js/auto';
import ChartDataLabels from 'chartjs-plugin-datalabels';
Chart.register(ChartDataLabels);
import { useClocks } from '../stores/Clock';
// import { useWorkingtimes } from "../stores/WorkingTimes";

// const workingTime = useWorkingtimes();
// workingTime.getworkingtimes();
const userClock = useClocks();
const token = localStorage.getItem("token");
const call = await axios.get("http://176.31.162.57:4000/api/workingtimes",
  {
    headers: { "Authorization": `Bearer ${token}` }
  }
);

const extract = call.data.data;

console.log(extract);

const json = (extract).reverse();





const dateDiffHour = function (date1, date2) {
  let dt1 = new Date(date1);
  let dt2 = new Date(date2);
  let results = {}
  let diffHours = (Math.round((Date.UTC(dt2.getFullYear(), dt2.getMonth(), dt2.getDate(), dt2.getHours(), dt2.getMinutes()) - Date.UTC(dt1.getFullYear(), dt1.getMonth(), dt1.getDate(), dt1.getHours(), dt1.getMinutes())) / (1000 * 60 * 60) * 100) / 100);
  let days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  let dayMonth = months[(dt2.getMonth())];
  let dayWeek = days[(dt2.getDay())];
  let fullDay = (dayWeek + ' ' + ' ' + dt2.getDate() + ' ' + dayMonth + ' ' + dt2.getFullYear())


  results = { day: dayWeek, workingHours: diffHours, fullDate: fullDay }

  return results
};



const analyze = function (file) {

  let dayList = []
  let workingTimesList = []
  let fullDays = []




  for (let i = 0; i < file.length && i < 5; i++) {
    workingTimesList.push(dateDiffHour(file[i].start, file[i].end).workingHours);
    dayList.push(dateDiffHour(file[i].start, file[i].end).day);
    fullDays.push(dateDiffHour(file[i].start, file[i].end).fullDate);
  }


  const dict = { "days": dayList, "workingTimes": workingTimesList, "fullDays": fullDays }
  return dict

};


const sum = function (array) {
  let sum = 0;
  array.forEach(item => {
    sum += item;
  });

  return sum;
}

const missingDays = function (file) {
  let listDays = []
  const daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

  if (file) {
    for (let i = 0; i < daysOfWeek.length; i++) {
      if (analyze(json).days.includes(daysOfWeek[i])) {
        listDays.push(1)
      }
      else {
        listDays.push(0)
      }

    }
    return listDays
  }
};

const analyze2 = function (dateDiff) {


};


console.log(missingDays(json))




export default {
  name: 'Charts',
  props: {
    label: {
      type: Array
    },
    chartData: {
      type: Array
    }
  },

  async mounted() {

    //////////////////////////////////////////// BAR CHART//////////////////////////////////////
    var options_Barch = {
      type: 'bar',
      data: {
        labels: (analyze(json).days).reverse(),
        datasets: [
          {
            label: 'Last 5 Days Worked',
            pointStyle: 'rectRot',
            pointRadius: 5,
            pointBorderColor: 'rgb(0, 0, 0)',
            data: (analyze(json).workingTimes).reverse(),




            backgroundColor: ['rgba(255, 255, 255, 0.8)'],
            borderWidth: 1,
            borderRadius: Number.MAX_VALUE,
            borderSkipped: false,
          },
        ]
      },
      options: {
        plugins: {
          datalabels: {
            align: 'center',
            color: 'rgba(4,7,21,255)',
            font: {
              weight: 'bold',
              size: 15
            },
            display: true

          }
        },
        scales: {
          y: {
            beginAtZero: true,
            grid: { display: false },
            ticks: { display: false }
          },
          x: {
            beginAtZero: true,
            grid: { display: false }
          }
        }
      }
    }

    ////////////////////////////////////////////// Mean CHART////////////////////////////////////////////
    var options_Bar_mean = {
      type: 'bar',
      data: {
        labels: ['Total Hours'],
        datasets:
          [{
            label: ' Total Hours',
            pointStyle: 'rectRot',
            pointRadius: 5,
            pointBorderColor: 'rgb(0, 0, 0)',
            data: [sum(analyze(json).workingTimes)],
            backgroundColor: ['rgba(255, 255, 255, 0.9)'],
            borderColor: ['rgba(255, 255, 255, 0.5)'],
            borderWidth: 5,
            borderRadius: Number.MAX_VALUE,
            borderSkipped: false,
          }]
      },
      options: {
        plugins: {
          datalabels: {
            align: 'center',
            color: 'rgba(4,7,21,255)',
            font: {

              weight: 'bold',
              size: 40
            },
            display: true

          }
        },
        scales: {
          y: {
            beginAtZero: true,
            grid: { display: false },
            ticks: { display: false }
          },
          x: {
            beginAtZero: true,
            grid: { display: false },
            ticks: { display: false }

          }
        }

      }
    }

    ////////////////////////////////////////////// GAUGE CHART//////////////////////////////////////////////
    var options_Gauge = {
      type: 'doughnut',
      data: {
        labels: ["Present", "Missing"],
        datasets: [
          {
            label: '# of Votes',
            data: [sum(missingDays(json)) * 100 / 5, (sum(missingDays(json)) * 100 / 5) - 100],
            backgroundColor: ["rgba(255,255,255, 0.9)", "rgba(255,255,255, 0.4)"]
          }
        ]
      },
      options: {
        rotation: 270, // start angle in degrees
        circumference: 180, // sweep angle in degrees
        plugins: {
          datalabels: {
            align: 'center',
            color: 'rgba(4,7,21,255)',
            font: {

              weight: 'bold',
              size: 15
            },
            formatter: function (value) {
              return Math.round(value) + '%';
            },
            display: true

          }
        }
      }
    }

    ////////////////////////////////////////////// SHOWING ALL CHARTS //////////////////////////////////////////////



    new Chart(this.$refs.Barchart, options_Barch);
    new Chart(this.$refs.Mean, options_Bar_mean);
    new Chart(this.$refs.Gauge, options_Gauge);



  }
}


</script>

<template>
  <div class="firstBlock">

    <div class="box-card">
      <div class="graph_bar">
        <canvas ref="Barchart" width="900" height="600"></canvas>
      </div>
    </div>
  </div>
  <div class="scdBlock">


    <div class="box-card">
      <div class="graph_mean">
        <canvas ref="Mean" width="200" height="200"></canvas>
      </div>
    </div>


    <div class="box-card">
      <div class="graph_gauge">
        <canvas ref="Gauge" width="200" height="200"></canvas>
      </div>
    </div>
  </div>
</template>


<style scoped>
.header {

  text-align: center;
}

.firstBlock {
  display: flex;
  justify-content: space-evenly;
}

.scdBlock {
  display: flex;
  justify-content: space-evenly;

}

.graph {

  display: flex;
  justify-content: space-evenly;
  background-color: rgba(0, 0, 0, 0.0);


}

.graph_bar {
  height: 200px;
  width: 300px;
  position: left;
  background: linear-gradient(rgba(4, 7, 21, 255), rgba(28, 42, 54, 255));
  border-radius: 30px;
  padding: 15px;
}

.graph_mean {
  margin-top: 10px;
  height: 80%;
  width: 80%;
  background: linear-gradient(rgba(4, 7, 21, 255), rgba(28, 42, 54, 255));
  border-radius: 30px;
  padding: 15px;
  object-fit: fill;
}


.graph_gauge {
  margin-top: 10px;
  height: 80%;
  width: 80%;
  position: right;
  background: linear-gradient(rgba(4, 7, 21, 255), rgba(28, 42, 54, 255));
  border-radius: 30px;
  padding: 15px;
}




.el-card {
  border-radius: 30px;
  border: 0px transparent;
  overflow: hidden;
  transition: var(--el-transition-duration);
  --el-card-padding: 0%;

}


.el-card__body {
  border-radius: 30px;
  border: 0px transparent;
  overflow: visible;
  transition: var(--el-transition-duration);
  --el-card-padding: 0%;

}


.el-col-6 {
  max-width: 50%;
  background-color: transparent;


}

.el-card.is-always-shadow {
  background-color: transparent;
}




.el-row.is-justify-space-evenly {
  justify-content: space-evenly;

  margin: 15%;
}
</style>

