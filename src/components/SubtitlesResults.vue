<template>
    <div class="card">
        <h1 ref="title" class="title">Subtitles</h1>
        <p class="note">Results fetched from <a href="https://www.opensubtitles.org" target="_blank">opensubtitles.org</a>.</p>

        <subtitle-card
            class="subs-results"
            v-for="(sub, id) in subtitles"
            v-bind:key="id"
            v-bind:name="sub.SubFileName"
            v-bind:downloads="sub.SubDownloadsCnt"
            v-bind:rating="sub.SubRating"
            v-bind:openLink="sub.SubtitlesLink"
            v-bind:downloadLink="sub.ZipDownloadLink"
        ></subtitle-card>
        <p v-if="noSubtitles" style="font-weitgh: bold;">
            <br>
            Sorry, we couldn't find subtitles for your movie! 
            Try using both methods (file select and title search) and
            if you still cannot get any results try <a href="http://easysubtitles.com/" target="_blank">SubDB's</a> app.
        </p>
    </div>
</template>

<style lang="scss" scoped>
@import '../styles/components/SubtitlesResults.scss';
</style>

<script>
import {EventBus} from '../event-bus'
import SubtitleCard from './SubtitleCard.vue'

export default {

    components: {
        SubtitleCard
    },

    data() {
        return {
            method: '',
            imdbID_hash: '',
            languageCode: '',
            subtitles: [],
            noSubtitles: false
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
            document.getElementsByClassName('subs-results').forEach(el => {
                el.classList.add('hidden');
            });
            setTimeout(() => {
                this.subtitles = [];
            }, 1000);
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
            document.getElementsByClassName('subs-results').forEach(el => {
                el.classList.add('hidden');
            });
            setTimeout(() => {
                this.subtitles = [];
            }, 1000);
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
                        this.subtitles = data;
                        if (data.length === 0)
                            this.noSubtitles = true;
                        else 
                            this.noSubtitles = false;
                    })
                    .catch(function(err) {
                        console.log("[SEARCHING SUBS ERROR]: "+err);
                });
        }
    }
}
</script>