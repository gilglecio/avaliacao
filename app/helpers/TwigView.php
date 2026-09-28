<?php

/**
 * View do Slim 2 renderizada com Twig 3 (substitui o pacote slim/views,
 * que só suporta Twig 1).
 */
class TwigView extends \Slim\View
{
    /**
     * @var array Opções do Twig\Environment
     */
    public $parserOptions = array();

    /**
     * @var array Extensões do Twig
     */
    public $parserExtensions = array();

    /**
     * @var \Twig\Environment|null
     */
    private $parserInstance = null;

    public function render($template, $data = null)
    {
        $data = array_merge($this->all(), (array) $data);

        return $this->getInstance()->render($template, $data);
    }

    public function getInstance()
    {
        if ($this->parserInstance === null) {
            $loader = new \Twig\Loader\FilesystemLoader($this->getTemplatesDirectory());

            $this->parserInstance = new \Twig\Environment($loader, $this->parserOptions);

            foreach ($this->parserExtensions as $extension) {
                $this->parserInstance->addExtension($extension);
            }
        }

        return $this->parserInstance;
    }
}
