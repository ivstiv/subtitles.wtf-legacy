<template>
    <div class="card">
        <h1>Search by title</h1>
        <div class="search">
            <input type="text" v-model="queryTitle" class="search__input" placeholder="Movie title...">
            <div class="search__icon">
                <i class="fas fa-search"></i>
            </div>
            <div class="btn btn__primary" @click="search">
                <p>Search</p>
            </div>
        </div>
        <p v-if="searchError" class="note error">
            {{ searchError }}
        </p>
        <p class="note">
            Data provided by <a href="https://www.omdbapi.com/" target="_blank">OMDb API</a>.
        </p>
    </div>
</template>


<script>
import {EventBus} from '../event-bus'

export default {
    data() {
        return {
            queryTitle: "",
            searchError: ""
        }
    },

    methods: {
        search() {
            if(this.queryTitle.trim()) {
                this.searchError = "";
                console.log('Searching title:'+this.queryTitle.trim())
                fetch('https://subtitles.wtf/movies.php?query='+this.queryTitle.trim()) 
                    .then(response => response.json())
                    .then(data => {
                        console.log(data);
                        if(data.Error) {
                            this.searchError = data.Error;
                        }else{
                            EventBus.$emit('movie-results', data.Search);
                        }
                    })
                    .catch(function(err) {
                        console.log("[SEARCHING ERROR]: "+err);
                    });
            }else{
                this.queryTitle = "";
            }
        }
    }
}
</script>

<style lang="scss" scoped>
@import '../styles/components/TitleSearch.scss';
</style>