<template>
    <div>
        <div class="card">
            <h1 ref="title" class="title">Subtitles</h1>
            <p class="note">Results fetched from <a href="https://www.opensubtitles.org" target="_blank">opensubtitles.org</a>.</p>
        </div>
    </div>
</template>

<style lang="scss" scoped>
@import '../styles/components/SubtitlesResults.scss';
</style>

<script>
import {EventBus} from '../event-bus'

export default {

    data() {
        return {
            method: '',
            imdbID_hash: '',
            languageCode: '',
            subtitles: []
        }
    },

    mounted() {
        // MovieCard emits selected-movie
        EventBus.$on('selected-movie', (movie) => {
            this.method = 'imdbid';
            this.imdbID_hash = movie.imdbid;

            if(this.readyToFetch())
                this.fetchSubs();
        });

        EventBus.$on('selected-hash', (hash) => {
            this.method = 'hash';
            this.imdbID_hash = hash;

            if(this.readyToFetch())
                this.fetchSubs();
        });

        EventBus.$on('selected-hash-clear', () => {
            this.method = '';
            this.imdbID_hash = '';
        });

        // LanguageSearch emits selected-lang
        EventBus.$on('selected-lang', (lang) => {
            this.languageCode = lang.code;

            if(this.readyToFetch())
                this.fetchSubs();
        });

        // LanguageSearch emits selected-lang-clear
        EventBus.$on('selected-lang-clear', () => {
            this.languageCode = '';
        });
    },

    methods: {

        readyToFetch() {
            if(this.method === '') return false;
            if(this.imdbID_hash === '') return false;
            if(this.languageCode === '') return false;
            return true;
        },

        fetchSubs() {

            let url = `https://subtitles.wtf/api/subtitles.php?query=sublanguageid-${this.languageCode}/`;
            if(this.method === 'imdbid')
                url = url+`imdbid-${this.imdbID_hash}`;
            else if (this.method === 'hash')
                url = url+`moviehash-${this.imdbID_hash}`;
            fetch(url)
                .then(response => response.json())
                    .then(data => {
                        console.log(data);
                    })
                    .catch(function(err) {
                        console.log("[SEARCHING SUBS ERROR]: "+err);
                });
        }
    }
}
</script>