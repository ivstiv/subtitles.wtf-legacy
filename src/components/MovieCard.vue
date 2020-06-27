<template>
<div class="movie-card item">
    <img :src="getPoster" alt="poster">
    <h1>{{ this.title }}</h1>
    <div class="buttons">
        <div class="btn btn__primary">
            <p>Select</p>
        </div>
        <div class="icon">
            <i class="fas fa-info"></i>
        </div>
    </div>
</div>
</template>

<script>
export default {
    props: ['title', 'poster', 'imdbID'],

    computed: {
        getPoster: function() {
            if (this.poster == 'N/A')
                return require("../assets/no-image.jpg");
            else 
                return this.poster;
        }
    }
}
</script>

<style lang="scss" scoped>
    @import '../styles/components/MovieCard.scss';
</style>