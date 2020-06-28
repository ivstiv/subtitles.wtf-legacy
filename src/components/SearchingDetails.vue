<template>
    <div class="card searching-details">
        <h1>Searching details</h1>
        <h2>Searching by:
            <span> {{ this.method }}</span>
        </h2>
        <h2>Title/Hash:
            <span> {{ this.title_hash }}</span>
        </h2>
        <h2>Language:
            <span v-if="language" >{{ this.language }}</span>
            <!--<span v-else><a v-scroll-to="'#langSearch'">Choose a language</a></span>-->
            <span v-else>Choose a language</span>
        </h2>
    </div>
</template>

<style lang="scss" scoped>
@import '../styles/components/SearchingDetails.scss';
</style>

<script>
import {EventBus} from '../event-bus'

export default {
    data() {
        return {
            method: "",
            title_hash: "",
            language: ""
        }
    },

    mounted() {
        EventBus.$on('selected-movie', (movie) => {
            this.method = `IMDB ID (${movie.imdbid})`;
            this.title_hash = movie.title;
        });

        EventBus.$on('selected-hash', (hash) => {
            this.method = 'Hash';
            this.title_hash = hash;
        });

        EventBus.$on('selected-hash-clear', () => {
            this.method = '';
            this.title_hash = '';
        });

        EventBus.$on('selected-lang', (lang) => {
            this.language = lang.name;
        });

        EventBus.$on('selected-lang-clear', () => {
            this.language = "";
        });
    }
}
</script>