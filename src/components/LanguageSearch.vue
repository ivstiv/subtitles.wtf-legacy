<template>
        <div class="card">
            <h1 id="langSearch" ref="langSearch" class="title">Choose a language</h1>
            <div class="search">
                <input type="text" v-model="queryLang" @input="updateRecommendedLangs" class="search__input" placeholder="Language..." />
                <div class="search__icon">
                    <i class="fas fa-search"></i>
                </div>
            </div>
            <div class="chips">
                <div class="chip" 
                    v-if="this.selectedLang"
                    @click="clearLang()">
                    <div class="chip__icon">
                        <i class="fas fa-flag"></i>
                    </div>
                    <p>{{this.selectedLang.name}}</p>
                    <div class="chip__close">
                        <i class="fas fa-times"></i>
                    </div>
                </div>
                <div class="chip" 
                    v-for="(lang, id) in recommendedLangs" 
                    v-bind:key="id"
                    @click="selectLang(lang.code)">
                    <div class="chip__icon">
                        <i class="far fa-flag"></i>
                    </div>
                    <p>{{lang.name}}</p>
                    <div class="chip__close">
                        <i class="fas fa-times"></i>
                    </div>
                </div>
                <span class="tip">{{ this.tip }}</span>
            </div>
            <p v-if="!selectedLang && recommendedLangs.length === 0 "  class="note">
                Start typing and click the chip.
            </p>
        </div>
</template>

<style lang="scss" scoped>
@import '../styles/components/LanguageSearch.scss';
</style>

<script>
import {EventBus} from '../event-bus'
import jsonLanguages from '../assets/languages.json'

export default {
    data() {
        return {
            languages: jsonLanguages,
            queryLang: "",
            recommendedLangs: [],
            selectedLang: '',
            tip: ""
        }
    },

    mounted() {
        // MovieCard emits selected-movie
        EventBus.$on('selected-movie', () => {
            this.$scrollTo(this.$refs.langSearch, {duration: 2000});
        });
    },

    methods: {
        updateRecommendedLangs() {
            if (this.queryLang) {
                // filter the results
                let langs = this.languages.filter((lang) => {
                                return lang.name.toUpperCase().includes(this.queryLang.toUpperCase());
                            });
                // remove the already selected language
                if (this.selectedLang)
                    langs = langs.filter(lang => {return lang.name !== this.selectedLang.name});
                // take only 2 of them and show the rest in the tip
                this.recommendedLangs = langs.slice(0,2);
                if (langs.length-2 > 0)
                    this.tip = `+${langs.length-2} more matches`;
                else
                    this.tip = "";
            }else{
                this.recommendedLangs = [];
                this.tip = "";
            }
        },

        selectLang(code) {
            this.selectedLang = this.languages.filter(lang => {return lang.code === code})[0];

            // SearchingDetails listens for selected-lang 
            // SubtitlesResults listens for selected-lang 
            EventBus.$emit('selected-lang', this.selectedLang);
            // cleanup
            this.queryLang = '';
            this.recommendedLangs = [];
            this.tip = "";
        },

        clearLang() {
            this.selectedLang = "";
            // SearchingDetails listens for selected-lang-clear
            // SubtitlesResults listens for selected-lang-clear
            EventBus.$emit('selected-lang-clear', this.selectedLang);
        }
    }
}
</script>