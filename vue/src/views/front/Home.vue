<template>
  <div class="main-content">
<!--    <div style="height: 60px; background-color: #b8efcf"></div>-->
    <div style="display: flex; height: 400px;width: 100%; background-color: white">
      <div style="flex: 1;height: 400px; background-color:#11A983; color: #efebeb;padding: 5px 0 0 5px">
        <div style="display: flex; background-color: #11A983;color: #f5f5f5;" v-for="item in typeData">
          <img :src=" item.img" alt="" style="height: 20px; width: 20px;margin: 5px;">
          <div style="margin: 5px; font-size: 14px;color: white"><a style="color:#efebeb" href="#" @click="navTo('/front/type?id=' + item.id)">{{item.name}}</a></div>
        </div>
      </div>
      <div style="flex: 6">
        <div>
          <el-carousel height="400px" style="">
            <el-carousel-item v-for="item in carousel_top">
              <img :src="item" alt="" style="width: 100%; height: 400px; ">
            </el-carousel-item>
          </el-carousel>
        </div>
      </div>
    </div>
    <div>
      <el-tabs type="border-card">
        <el-tab-pane label="热卖商品">
          <div style="margin: 10px 5px 0 5px">
            <el-row>
              <el-col :span="5" v-for="item in goodsData">
                <img @click="navTo('/front/detail?id=' + item.id)" :src="item.img" alt="" style="width: 100%; height: 175px; border-radius: 10px; border: #cccccc 1px solid">
                <div style="margin-top: 10px; font-weight: 500; font-size: 16px; width: 180px; color: #000000FF; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">{{item.name}}</div>
                <div style="margin-top: 5px; font-size: 20px; color: #FF5000FF">￥ {{item.price}} / {{item.unit}}</div>
              </el-col>
            </el-row>
          </div></el-tab-pane>
        <el-tab-pane label="猜你喜欢">
          <div style="margin: 10px 5px 0 5px">
            <el-row>
              <el-col :span="5" v-for="item in recommendData" :key="item.id">
                <img @click="navTo('/front/detail?id=' + item.id)" :src="item.img" alt="" style="width: 100%; height: 175px; border-radius: 10px; border: #cccccc 1px solid">
                <div style="margin-top: 10px; font-weight: 500; font-size: 16px; width: 180px; color: #000000FF; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">{{item.name}}</div>
                <div style="margin-top: 5px; font-size: 20px; color: #FF5000FF">￥ {{item.price}} / {{item.unit}}</div>
              </el-col>
            </el-row>
          </div>
        </el-tab-pane>
      </el-tabs>
    </div>

  </div>
</template>

<script>

export default {

  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      typeData: [],
      top: null,
      notice: [],
      goodsData: [],
      recommendData: [],
      carousel_top: [
        require('@/assets/imgs/轮播图1.jpg'),
        require('@/assets/imgs/轮播图2.jpg'),
        require('@/assets/imgs/轮播图3.jpg'),
        require('@/assets/imgs/轮播图4.jpg'),
        require('@/assets/imgs/轮播图5.jpg'),
      ],
      carousel_left: [
        require('@/assets/imgs/carousel-3.png'),
        require('@/assets/imgs/carousel-4.png'),
        require('@/assets/imgs/carousel-5.png'),
      ],
      carousel_right: [
        require('@/assets/imgs/carousel-6.png'),
        require('@/assets/imgs/carousel-7.png'),
        require('@/assets/imgs/carousel-8.png'),
      ],
    }
  },
  mounted() {
    this.loadType()
    this.loadNotice()
    this.loadGoods()
    this.loadRecommend()
  },
  // methods：本页面所有的点击事件或者其他函数定义区
  methods: {
    loadRecommend() {
      this.$request.get('/goods/recommend').then(res => {
        if (res.code === '200') {
          console.log("获取推荐列表")
          this.recommendData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    loadType() {
      this.$request.get('/type/selectAll').then(res => {
        if (res.code === '200') {
          this.typeData = res.data.slice(0,13)
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    loadNotice() {
      this.$request.get('/notice/selectAll').then(res => {
        this.notice = res.data
        let i = 0
        if (this.notice && this.notice.length) {
          this.top = this.notice[0].content
          setInterval(() => {
            this.top = this.notice[i].content
            i++
            if (i === this.notice.length) {
              i = 0
            }
          }, 2500)
        }
      })
    },
    loadGoods() {
      this.$request.get('/goods/selectTop15').then(res => {
        if (res.code === '200') {
          this.goodsData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    navTo(url) {
      location.href = url
    },
  }
}
</script>

<style scoped>
.main-content {
  min-height: 100vh;
  /*overflow: hidden;*/
  background-size: 100%;
  background-color: #f3f3f3;
}
.left {
  width: 17%;
  background-repeat: no-repeat;
  //background-image: url('@/assets/imgs/left-img.png');
  background-color: #b8efcf
}
.right {
  width: 17%;
  background-repeat: no-repeat;
  background-color: #b8efcf;
}
.el-col-5{
  width: 20%;
  max-width: 20%;
  padding: 10px 10px;
}
</style>