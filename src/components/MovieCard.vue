<template>
<div class="movie-card item">
    <img :src="getPoster" alt="poster">
    <h1>{{ this.title }}</h1>
    <div class="buttons">
        <div class="btn btn__primary" @click="selectMovie">
            <p>Select</p>
        </div>
        <div class="icon">
            <i class="fas fa-info"></i>
        </div>
    </div>
</div>
</template>

<script>
import {EventBus} from '../event-bus'

export default {
    props: ['title', 'poster', 'imdbID'],

    computed: {
        getPoster: function() {
            if (this.poster == 'N/A')
                return require("../assets/no-image.jpg");
            else 
                return this.poster;
        }
    },

    methods: {
        selectMovie() {
            console.log('Selected movie:'+this.imdbID);
            // LanguageSearch listens for selected-movie
            // MovieResults listens for selected-movie
            // SearchingDetails listens for selected-movie
            // SubtitlesResults listens for selected-movie
            EventBus.$emit('selected-movie', {"title": this.title, "imdbid": this.imdbID});
        }
    }
}
</script>

<style lang="scss" scoped>
    @import '../styles/components/MovieCard.scss';
</style>