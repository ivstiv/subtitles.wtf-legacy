<template>
	<div id="app" v-cloak @drop.prevent="fileDropped" @dragover.prevent>
		
		<div class="header-wrapper">
			<div class="left-chips">
				<div class="chip" @click="redirectTo('https://github.com/Ivstiv/subtitles.wtf')">
					<div class="chip__icon">
						<i class="fab fa-github"></i>
					</div>
					<p>Available on Github</p>
					<div class="chip__close">
						<i class="fas fa-check"></i>
					</div>
				</div>

				<div class="chip">
					<div class="chip__icon">
						<i class="fas fa-user-secret"></i>
					</div>
					<p>No advertisements</p>
					<div class="chip__close">
						<i class="fas fa-check"></i>
					</div>
				</div>

				<div class="chip">
					<div class="chip__icon">
						<i class="fas fa-moon"></i>
					</div>
					<p>Dark theme support</p>
					<div class="chip__close">
						<i class="fas fa-check"></i>
					</div>
				</div>
			</div>
			
			<div class="logo">
				<img src="./assets/logo2.png" alt="logo">
			</div>

			<div class="right-chips">
				<div class="chip" @click="redirectTo('https://github.com/Ivstiv/subtitles.wtf/issues')">
					<div class="chip__icon">
						<i class="fas fa-exclamation-triangle"></i>
					</div>
					<p>There is a problem</p>
					<div class="chip__close">
						<i class="fas fa-question"></i>
					</div>
				</div>

				<div class="chip">
					<div class="chip__icon" @click="redirectTo('https://github.com/Ivstiv/subtitles.wtf/issues')">
						<i class="fas fa-user-edit"></i>
					</div>
					<p>Additional features</p>
					<div class="chip__close">
						<i class="fas fa-question"></i>
					</div>
				</div>

				<div class="chip" @click="redirectTo('https://discord.gg/VMSDGVD')">
					<div class="chip__icon">
						<i class="fab fa-discord"></i>
					</div>
					<p>Find me on Discord</p>
					<div class="chip__close">
						<i class="fas fa-question"></i>
					</div>
				</div>
			</div>
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
		},

		redirectTo(url) {
			window.open(url, '_blank');
		}
	}
};
</script>

<style lang="scss">
@import 'styles/global.scss';

.logo {
	width: 55rem;
	border-radius: 3rem;
	box-shadow: 0.8rem 0.8rem 1.4rem var(--greyLight-2),
				-0.2rem -0.2rem 1.8rem var(--white);
	padding: 2rem;
	margin-top: 1rem;
	margin-left: -5rem;
	cursor: pointer;

	@media (max-width: 560px) {
		width: 35rem;
	}

	@media (max-width: 1700px) {
			margin-left: 0;
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

.chip {
	width: 23rem;
}

.header-wrapper {
	display: flex;
    flex-direction: row;
    flex-wrap: wrap;
	justify-content: space-around;

	.left-chips, .right-chips {
		display: flex;
		flex-direction: column;
		justify-content: center;
		margin: 0 auto;

		@media (max-width: 1116px) {
			display: none;
		}
	}
}

</style>