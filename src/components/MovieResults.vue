<template>
    <div id="movieResults" v-if="movieResults.length > 0" class="movie-results">
        <h1 class="title">Pick your movie</h1>
        <div class="grid-container">
            <main class="grid-item main">
                <div ref="slider" class="items" :class="{ active: isDown }"  
                    @mousedown="mouseDown" 
                    @mouseleave="mouseLeave" 
                    @mouseup="mouseUp" 
                    @mousemove="mouseMove" 
                    v-touch:swipe="stopAutoScrollAnimation">
                    <div v-for="(movie, id) in movieResults" v-bind:key="id" class="card item">
                        <img :src="movie.Poster" alt="poster">
                        <h1>{{ movie.Title }}</h1>
                        <div class="buttons">
                            <div class="btn btn__primary">
                                <p>Select</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-info"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
</template>

<script>
import {EventBus} from '../event-bus'

export default {
    data() {
        return {
            slider: null,
            isDown: false,
            startX: null,
            scrollLeft: null,
            movieResults: [],
            scrollingAnimation: null
        }
    },

    mounted() {
        EventBus.$on('movie-results', movies => {
            this.movieResults = movies;
            if(this.$refs.slider)
                this.$refs.slider.scrollLeft = 0;
            clearInterval(this.scrollingAnimation);
            this.scrollingAnimation = setInterval(() => {
                this.$refs.slider.scrollLeft = this.$refs.slider.scrollLeft + 1;
            }, 10);
        });
    },

    updated() {
        this.slider = this.$refs.slider;
        this.$scrollTo(this.slider, {duration: 2000});
    },

    methods:{
        mouseDown(e) {
            e.preventDefault();
            this.isDown = true;
            this.startX = e.pageX - this.slider.offsetLeft;
            this.scrollLeft = this.slider.scrollLeft;
            this.stopAutoScrollAnimation();
        },

        mouseMove(e) {
            if(!this.isDown) return;
            const x = e.pageX - this.slider.offsetLeft;
            const walk = x - this.startX;
            this.slider.scrollLeft = this.scrollLeft - walk;
        },

        mouseLeave() {
            this.isDown = false;
        },

        mouseUp() {
            this.isDown = false;
        },

        stopAutoScrollAnimation() {
            if(this.scrollingAnimation) {
                clearInterval(this.scrollingAnimation);
                this.scrollingAnimation = null;
            }
        }
    }
}
</script>

<style lang="scss" scoped>
@import '../styles/components/MovieResults.scss';
</style>