<template>
	<div id="app" v-cloak @drop.prevent="fileDropped" @dragover.prevent>
		<div class="logo">
			<img src="./assets/logo2.png" alt="logo">
		</div>
		<div class="searching-wrapper">
			<upload-file></upload-file>
			<h1 class="or">OR</h1>
			<SearchTitle></SearchTitle>
		</div>
		<movie-results></movie-results>
		<LanguageSearch></LanguageSearch>
	</div>
</template>

<script>
import {EventBus} from './event-bus'
import SearchTitle from './components/TitleSearch.vue'
import MovieResults from './components/MovieResults.vue'
import LanguageSearch from './components/LanguageSearch.vue'
import UploadFile from './components/UploadFile.vue'

export default {
	name: "App",
	components: {
		SearchTitle,
		LanguageSearch,
		UploadFile,
		MovieResults
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
	@media (max-width: 1124px) {
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

</style>