export interface User {
  username: string;
  password: string;
  registrationDate: Date;
}

export interface ExerciseData {
  recordDate: Date;
  duration: number;
  caloriesBurned: number;
}

export interface DietPlan {
  planName: string;
  creationDate: Date;
  nutritionInfo: string;
}

export interface ExercisePlan {
  planName: string;
  planContent: string;
}

export interface Device {
  id: string;
  name: string;
  image: Resource;
  isConnected: boolean;
}

export interface SportRecord {
  id: number;
  title: string;
  duration: string;
  calories: number;
  date: string;
}

export interface SportPlan {
  id: number;
  title: string;
  duration: string;
  description: string;
}

export interface SportTutorial {
  id: number;
  title: string;
  image: Resource;
}

export interface DietRecord {
  date: string;
  totalCalories: number;
  details: string;
  expanded?: boolean;
}

export interface DietSuggestion {
  nutritionRecommendation: string;
  healthAdvice: string;
}