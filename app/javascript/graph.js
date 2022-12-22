window.addEventListener('load', function(){

  const ctx = document.getElementById("achievmentGraph")
  const achievmentGraph = new Chart(ctx, {
    type: 'pie',
    data: {
      labels:['達成率','目標達成まで残り'],
      datasets:[{
        label: '達成率',
        backgroundColor: ['#00ffff','#f0ffff'],
        data: gon.graph_data,
      }]
    },
  })
})
