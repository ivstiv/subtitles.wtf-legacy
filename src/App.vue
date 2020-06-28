<template>
	<div id="app" v-cloak @drop.prevent="fileDropped" @dragover.prevent>
		<div id="forkme">
			<a href="https://github.com/Ivstiv/subtitles.wtf" target="_blank">Find me on <i class="fab fa-github"></i></a>
		</div>
		<div class="logo">
			<img src="./assets/logo2.png" alt="logo">
		</div>
		<movie-results></movie-results>
		<div class="searching-wrapper">
			<upload-file></upload-file>
			<!--<h1 class="or">OR</h1>-->
			<SearchTitle></SearchTitle>
			<language-search></language-search>
		</div>
		<div class="searching-wrapper">
			
			<!--<h1 class="or">AND</h1>-->
			<SearchingDetails></SearchingDetails>
		</div>
		<subtitles-results></subtitles-results>
	</div>
</template>

<script>
import {EventBus} from './event-bus'
import SearchTitle from './components/TitleSearch.vue'
import MovieResults from './components/MovieResults.vue'
import UploadFile from './components/UploadFile.vue'
import SubtitlesResults from './components/SubtitlesResults.vue'
import LanguageSearch from './components/LanguageSearch.vue'
import SearchingDetails from './components/SearchingDetails.vue'

export default {
	name: "App",
	components: {
		SearchTitle,
		UploadFile,
		MovieResults,
		LanguageSearch,
		SearchingDetails,
		SubtitlesResults
	},
	methods: {
		fileDropped(e) {
			let droppedFiles = e.dataTransfer.files;
			if(!droppedFiles) return;
			EventBus.$emit('file-upload', droppedFiles[0]);
		}
	}
};
</script>

<style lang="scss">
@import 'styles/global.scss';

.logo {
	width: 50rem;
	border-radius: 3rem;
	box-shadow: 0.8rem 0.8rem 1.4rem var(--greyLight-2),
				-0.2rem -0.2rem 1.8rem var(--white);
	padding: 2rem;
	margin: 0 auto;
	margin-top: 1rem;
	cursor: pointer;

	@media (max-width: 560px) {
		width: 35rem;
	}

	img {
		max-width: 100%;
		height: auto;
		box-shadow: $shadow;
		padding: 5rem;
		margin: 0 auto;
		border-radius: 3rem;
	}

	&:active img {
		box-shadow: $inner-shadow;
	}
}

.or {
	font-size: 5rem;
	@media (max-width: 1193px) {
		width: 100%;
		text-align: center;
    }
}

.searching-wrapper {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
	justify-content: space-evenly;
	margin-top: 3rem;
}


#forkme {
    transform: rotate(45deg);
    background-color: #FFF;
    overflow: hidden;
    position: absolute;
    z-index: 300;
    width: 240px;
    right: -60px;
    top: 46px;
    border-style: solid;
    border-color: #000;
}

#forkme a {
    color: #404040;
    display: block;
    /*font: 13px Helvetica Neue,Arial,sans-serif;*/
    margin: 0.05em 0px 0.075em;
    padding: 0.6em;
    text-align: center;
    text-decoration: none;
}

</style>