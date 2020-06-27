<template>
    <div class="lang-search-wrapper">
        <div class="card">
            <h1>Choose a language</h1>
            <div class="search">
                <input type="text" v-model="queryLang" @keypress="updateRecommendedLangs" class="search__input" placeholder="Language..." />
                <div class="search__icon">
                    <i class="fas fa-search"></i>
                </div>
            </div>
            <div class="chips">
                <div class="chip" 
                    v-for="(lang, id) in recommendedLangs" 
                    v-bind:key="id">
                    <div class="chip__icon">
                        <i class="far fa-flag"></i>
                    </div>
                    <p>{{lang.name}}</p>
                    <div class="chip__close">
                        <i class="fas fa-times"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style lang="scss" scoped>
@import '../styles/components/LanguageSearch.scss';
</style>

<script>
import jsonLanguages from '../assets/languages.json'

export default {
    data() {
        return {
            languages: jsonLanguages,
            queryLang: "",
            recommendedLangs: []
        }
    },

    methods: {
        updateRecommendedLangs() {
            if (this.queryLang.length < 2) return;

            let langs = this.languages.filter((lang) => {
                return lang.name.toUpperCase().includes(this.queryLang.toUpperCase());
            });

            if (langs.length < 4 && langs.length > 0) {
                this.recommendedLangs = langs;
            }
        }
    }
}
</script>