<template>
    <div class="movie-results">
        <h1 class="title">Pick your movie</h1>
        <div class="grid-container">
            <main class="grid-item main">
                <div ref="slider" class="items" :class="{ active: isDown }"  @mousedown="mouseDown" @mouseleave="mouseLeave" @mouseup="mouseUp" @mousemove="mouseMove">
                    <div class="card item">
                        <img src="https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg" alt="poster">
                        <h1>The Avengers</h1>
                        <div class="buttons">
                            <div class="btn btn__primary">
                                <p>Select</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-info"></i>
                            </div>
                        </div>
                    </div>

                    <div class="card item">
                        <img src="https://m.media-amazon.com/images/M/MV5BMjMxNjY2MDU1OV5BMl5BanBnXkFtZTgwNzY1MTUwNTM@._V1_SX300.jpg" alt="poster">
                        <h1>Avengers: Infinity War</h1>
                        <div class="buttons">
                            <div class="btn btn__primary">
                                <p>Select</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-info"></i>
                            </div>
                        </div>
                    </div>

                    <div class="card item">
                        <img src="https://m.media-amazon.com/images/M/MV5BMTM4OGJmNWMtOTM4Ni00NTE3LTg3MDItZmQxYjc4N2JhNmUxXkEyXkFqcGdeQXVyNTgzMDMzMTg@._V1_SX300.jpg" alt="poster">
                        <h1>Avengers: Age of Ultron</h1>
                        <div class="buttons">
                            <div class="btn btn__primary">
                                <p>Select</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-info"></i>
                            </div>
                        </div>
                    </div>

                    <div class="card item">
                        <img src="https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_SX300.jpg" alt="poster">
                        <h1>Avengers: Endgame</h1>
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
export default {
    data() {
        return {
            slider: null,
            isDown: false,
            startX: null,
            scrollLeft: null
        }
    },

    mounted() {
        this.slider = this.$refs.slider;
    },

    methods:{
        mouseDown(e) {
            e.preventDefault();
            this.isDown = true;
            this.startX = e.pageX - this.slider.offsetLeft;
            this.scrollLeft = this.slider.scrollLeft;
            
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
    }
}
</script>

<style lang="scss" scoped>
@import '../styles/components/MovieResults.scss';
</style>