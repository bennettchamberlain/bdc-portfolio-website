const letter = (name: string) => ({
  name,
  icon: (
    <span className="flex h-full w-full items-center justify-center bg-black text-[8px] font-bold text-white md:text-[10px]">
      {name.slice(0, 2).toUpperCase()}
    </span>
  ),
});

export const skills = [
  "Flutter",
  "Dart",
  "TypeScript",
  "JavaScript",
  "Python",
  "React",
  "Next.js",
  "HTML",
  "CSS",
  "PostgreSQL",
  "Firebase",
  "AWS",
  "Figma",
  "Git",
].map(letter);
